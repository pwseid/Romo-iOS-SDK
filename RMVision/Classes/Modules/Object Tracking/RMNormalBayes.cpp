//
//  RMNormalBayes.cpp
//  RMVision
//
//  Created on 9/27/13.
//  Copyright (c) 2013 Romotive, Inc. All rights reserved.
//
//  Rewritten for OpenCV 4.x: computes Normal Bayes model parameters
//  (mean, inverse covariance, log-determinant) directly from training data
//  rather than relying on the internal fields of the removed cv::NormalBayesClassifier.
//

#include "RMNormalBayes.h"
#include <iostream>
#include <map>
#include <algorithm>
#include <cmath>

using namespace cv;
using namespace std;

RMNormalBayes::RMNormalBayes() {}

bool RMNormalBayes::train(const Mat& samples, const Mat& labels)
{
    return computeModel(samples, labels);
}

bool RMNormalBayes::train(const Mat& samples, const Mat& labels,
                          const Mat& /*varIdx*/, const Mat& /*sampleIdx*/, bool /*update*/)
{
    // varIdx and sampleIdx are not used; update is treated as full retrain.
    return computeModel(samples, labels);
}

bool RMNormalBayes::computeModel(const Mat& samples, const Mat& labels)
{
    if (samples.empty() || labels.empty() || samples.rows != labels.rows)
        return false;

    // Work in double precision for numerical stability.
    Mat samplesd, labelsd;
    samples.convertTo(samplesd, CV_64F);
    labels.convertTo(labelsd, CV_64F);

    const int numFeatures = samplesd.cols;

    // Group row indices by class label.
    map<int, vector<int>> classIndices;
    for (int i = 0; i < labelsd.rows; i++) {
        int label = (int)labelsd.at<double>(i);
        classIndices[label].push_back(i);
    }

    _classModels.clear();

    for (auto& kv : classIndices) {
        const int label = kv.first;
        const vector<int>& indices = kv.second;
        const int n = (int)indices.size();

        // Assemble per-class sample matrix.
        Mat classSamples(n, numFeatures, CV_64F);
        for (int i = 0; i < n; i++) {
            samplesd.row(indices[i]).copyTo(classSamples.row(i));
        }

        // Mean (1 x numFeatures).
        Mat mean;
        reduce(classSamples, mean, 0, REDUCE_AVG);

        // Covariance (numFeatures x numFeatures), normalised by n.
        Mat covar;
        Mat meanForCovar = mean.clone();
        calcCovarMatrix(classSamples, covar, meanForCovar,
                        COVAR_NORMAL | COVAR_ROWS | COVAR_USE_AVG | COVAR_SCALE,
                        CV_64F);

        // Small regularisation to prevent singular matrices.
        covar += Mat::eye(numFeatures, numFeatures, CV_64F) * 1e-6;

        // Log-determinant and inverse covariance.
        double logDetCovar = log(abs(determinant(covar)));
        Mat invCovar = covar.inv(DECOMP_SVD);

        ClassModel model;
        model.label            = label;
        model.mean             = mean;
        model.invCovariance    = invCovar;
        model.logDetCovariance = logDetCovar;
        _classModels.push_back(model);
    }

    // Sort by label value so index 0 = smallest label, matching OpenCV 2.x ordering.
    sort(_classModels.begin(), _classModels.end(),
         [](const ClassModel& a, const ClassModel& b) { return a.label < b.label; });

    return true;
}

Mat RMNormalBayes::getMu(int classIndex) const
{
    if (classIndex < 0 || classIndex >= (int)_classModels.size()) return Mat();
    return _classModels[classIndex].mean;
}

Mat RMNormalBayes::getInvCovariance(int classIndex) const
{
    if (classIndex < 0 || classIndex >= (int)_classModels.size()) return Mat();
    return _classModels[classIndex].invCovariance;
}

double RMNormalBayes::getLogDetCovariance(int classIndex) const
{
    if (classIndex < 0 || classIndex >= (int)_classModels.size()) return 0.0;
    return _classModels[classIndex].logDetCovariance;
}

void RMNormalBayes::print() const
{
    cout << "Printing summary of normal bayes model:" << endl << endl;
    cout << "numClasses: " << _classModels.size() << endl;

    for (int i = 0; i < (int)_classModels.size(); i++) {
        cout << "Class label: " << _classModels[i].label << endl;
        cout << "Mean: " << _classModels[i].mean << endl;
        cout << "Log Det Covariance: " << _classModels[i].logDetCovariance << endl;
        cout << "Inverse Covariance:" << endl << _classModels[i].invCovariance << endl;
    }
}

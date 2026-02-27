//
//  RMNormalBayes.h
//  RMVision
//
//  Created on 9/27/13.
//  Copyright (c) 2013 Romotive, Inc. All rights reserved.
//
//  Rewritten for OpenCV 4.x compatibility: computes Normal Bayes model
//  parameters directly rather than subclassing the removed cv::NormalBayesClassifier.
//

#ifndef __RMVision__RMNormalBayes__
#define __RMVision__RMNormalBayes__

#ifdef __OBJC__
#undef YES
#undef NO
#endif
#include <opencv2/opencv.hpp>
#ifdef __OBJC__
#define YES ((BOOL)1)
#define NO  ((BOOL)0)
#endif
#include <vector>

class RMNormalBayes
{
public:
    RMNormalBayes();

    // Train with samples (N x M, CV_32F) and labels (N x 1, CV_32F).
    bool train(const cv::Mat& samples, const cv::Mat& labels);

    // Incremental re-train; varIdx and sampleIdx are ignored (full retrain performed).
    bool train(const cv::Mat& samples, const cv::Mat& labels,
               const cv::Mat& varIdx, const cv::Mat& sampleIdx, bool update);

    // Mean vector for the class at classIndex (1 x M, CV_64F).
    cv::Mat getMu(int classIndex) const;

    // Inverse covariance matrix for the class at classIndex (M x M, CV_64F).
    cv::Mat getInvCovariance(int classIndex) const;

    // Log of the determinant of the covariance matrix for the class at classIndex.
    double getLogDetCovariance(int classIndex) const;

    int getNumClasses() const { return (int)_classModels.size(); }

    void print() const;

private:
    struct ClassModel {
        int      label;
        cv::Mat  mean;           // 1 x numFeatures, CV_64F
        cv::Mat  invCovariance;  // numFeatures x numFeatures, CV_64F
        double   logDetCovariance;
    };

    std::vector<ClassModel> _classModels;

    bool computeModel(const cv::Mat& samples, const cv::Mat& labels);
};

#endif /* defined(__RMVision__RMNormalBayes__) */

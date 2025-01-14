#pragma once

#include "enums.h"
#include "option.h"
#include "loss_description.h"

#include <util/generic/vector.h>

#include <functional>


namespace NJson {
    class TJsonValue;
}

namespace NCatboostOptions {
    struct TMetricOptions {
    public:
        explicit TMetricOptions();

        void Save(NJson::TJsonValue* options) const;
        void Load(const NJson::TJsonValue& options);

        bool operator==(const TMetricOptions& rhs) const;
        bool operator!=(const TMetricOptions& rhs) const;

        TOption<TLossDescription> EvalMetric;
        TOption<TLossDescription> ObjectiveMetric;
        TOption<TVector<TLossDescription>> CustomMetrics;
    };
}

bool IsValidForObjectiveOrEvalMetric(
    const ELossFunction objective,
    const NCatboostOptions::TMetricOptions& metricOptions,
    std::function<bool(ELossFunction)> predicate);


bool IsMultiClassOnly(
    const ELossFunction lossFunction,
    const NCatboostOptions::TMetricOptions& metricOptions);


void IterateOverObjectiveAndMetrics(
    const NCatboostOptions::TLossDescription& objective,
    const NCatboostOptions::TMetricOptions& metricOptions,
    std::function<void(const NCatboostOptions::TLossDescription&)>&& visitor);


bool IsAnyOfObjectiveOrMetrics(
    const NCatboostOptions::TLossDescription& objective,
    const NCatboostOptions::TMetricOptions& metricOptions,
    std::function<bool(ELossFunction)> predicate);


void ValidateIsMetricCalculationSupported(
    ELossFunction metric,
    ELossFunction lossFunction,
    ETaskType taskType);

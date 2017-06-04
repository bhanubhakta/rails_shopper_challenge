class Funnel
  def self.analytics(start_date, end_date)
    final_result = self.get_records(start_date, end_date)
    final_result_batch_hash(final_result)
  end

  def self.get_records(start_date, end_date)
    FunnelBatch.where("start_date >= ? AND end_date <= ?", Date.parse(start_date), Date.parse(end_date))
  end
  
  def self.final_result_batch_hash(results)
    final_result = {}
    results.each do |result|
      final_result[result.range] = {
        "applied" =>result.applied,
        "quiz_started" => result.quiz_started,
        "quiz_completed" => result.quiz_completed,
        "onboarding_requested" => result.onboarding_requested,
        "onboarding_completed" => result.onboarding_completed,
        "hired" => result.hired,
        "rejected" => result.rejected
      }
    end
    final_result
  end
end
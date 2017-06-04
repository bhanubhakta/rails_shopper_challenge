namespace :funnel do
  desc "Generate summary table"

  task :generate_summary => :environment do
    start_date = DateTime.now.utc.to_date.strftime
    save_summary({start_date: start_date})
  end

  desc "Generate summary table"
  task :summarize_all => :environment do
    save_summary({all_records: true})
  end

  task :add_applicant => :environment do
    Applicant.create!(first_name: "Bhanu Bhakta", last_name: "Sigdel", email: Faker::Internet.email, phone: Faker::PhoneNumber.cell_phone, phone_type: Applicant::PHONE_TYPES.sample, workflow_state: Applicant::WORKFLOW_STATES.sample, region: Applicant::REGIONS.sample)
  end

  def save_summary(options = {})
    results = Summary.build_and_save(options)
    results.each do |key, result|
      start_date = Date.parse(result["week_start"])
      end_date = Date.parse(result["week_end"])
      applied = result["applied"]
      quiz_started = result["quiz_started"]
      quiz_completed = result["quiz_completed"]
      onboarding_requested = result["onboarding_requested"]
      onboarding_completed = result["onboarding_completed"]
      hired = result["hired"]
      rejected = result["rejected"]

      funnel_batch = FunnelBatch.find_or_create_by!({
        start_date: start_date
      })

      funnel_batch.update({
        start_date: start_date, 
        end_date: end_date, 
        range: key, 
        applied: applied, 
        quiz_started: quiz_started, 
        quiz_completed: quiz_completed, 
        onboarding_requested: onboarding_requested, 
        onboarding_completed: onboarding_completed, 
        hired: hired, 
        rejected: rejected 
      })
    end
  end
end
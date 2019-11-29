class CancelScheduleRentalsJob
  attr_reader :limit_date
  def initialize(limit_date)
    @limit_date = limit_date
  end

  def self.auto_enqueue(limit_date)
    Delayed::Job.enqueue(CancelScheduleRentalsJob.new(limit_date))
  end

  def perform
    # Rental.scheduled.where("start_date < ?", limit_date).map(&:canceled!)
    Rental.scheduled.where("start_date < ?", limit_date).each do |r|
      r.status = 20
      r.save!
    end
  end
end
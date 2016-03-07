class JobLooper
  # A simple loop to repeat a job at a
  # set interval
  def initialize(model, job, period)
    @model_arr = model.all
    @job = job
    @period = period
  end

  def start_loop!
    loop do
      action
      sleep(@period)
    end
  end

  def action
    @model_arr.each do |model|
      @job.perform_later(model.id)
    end
  end
end

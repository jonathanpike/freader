Sidekiq.configure_client do |config|
        
    Rails.application.config.after_initialize do
        articles_loop = JobLooper.new(Site, FetchNewArticlesJob, 900)
        Thread.new do
            begin 
                articles_loop.start_loop!
            rescue => e
                Sidekiq::ExceptionHandler.handle_exception(e)
            end
        end
    end
end
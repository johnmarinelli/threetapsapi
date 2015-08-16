module ThreeTapsAPI
  @@valid_parameters = %w(category_group category radius 
                        lat long source external_id 
                        heading body text timestamp id 
                        price currency annotations status 
                        state has_image has_price include_deleted 
                        only_deleted location)
  def self.valid_parameters 
    @@valid_parameters
  end
  
  def self.valid_parameter?(str)
    @@valid_parameters.include? str
  end

  def self.invalid_parameter?(str)
    !self.valid_parameter? str
  end
end

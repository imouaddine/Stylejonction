module BackgroundValidator

  class CustomBackgroundValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        CustomBackground.find(value).present?
      rescue
        record.errors[attribute] << "There's no Custom Background with id = #{value}"
      end
    end
  end

  class PredefinedBackgroundValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        PredefinedBackground.find(value).present?
      rescue
        record.errors[attribute] << "There's no Predefined Background with id = #{value}"
      end
    end
  end

  class PatternBackgroundValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        PatternBackground.find(value).present?
      rescue
        record.errors[attribute] << "There's no Pattern Background with id = #{value}"
      end
    end
  end

end

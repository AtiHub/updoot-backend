module RequestHelpers
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end

    def json_errors_message
      json['errors'].first['message']
    end

    # user_not_authorized_error_message user_not_found_error_message
    # customer_not_found_error_message source_not_found_error_message
    %i(user_not_authorized user_not_found customer_not_found source_not_found).each do |method|
      define_method("#{method}_error_message") do
        I18n.t("api_v1_response_codes.#{method}")
      end
    end
  end
end

class ApplicationController < ActionController::API
  include ActionController::Cookies
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

def record_invalid_response e
  render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
end

def not_found_response
  render json: {errors: "Record Not found"}, status: :not_found
end

def authorize 
  return render json: {errors: ["Not Authorized"]}, status: :unauthorized unless session.include? :user_id
end 

end

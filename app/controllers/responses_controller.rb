class ResponsesController < ApplicationController

  def index
    @survey = Survey.find(params[:survey_id])
  end

  def create
    @survey = Survey.find(params[:survey_id])
    responses = []
    nested_response_params[:questions_attributes].each do |i, keyvals|
      # if question is radio, there's only one
      if keyvals[:question_id]
        p = {question_id: keyvals[:question_id], choice_id: keyvals[:id]}
        responses << Response.new(p)
      # if question is checkbox, there's an array of ids
      else
        keyvals[:choice_ids].each do |choice|
          unless choice.blank?
            p = {question_id: keyvals[:id], choice_id: choice}
            responses << Response.new(p)
          end
        end
      end
    end
    Response.transaction do
      responses.each(&:save!)
    end
    # begin
    #   @response.save!
    # rescue
    #   return render "surveys/show"
    # end
    redirect_to surveys_path
  end

  private

  def response_params
    params.permit(:question_id, :choice_id)
  end

  def nested_response_params
    params.require(:survey).permit(:questions_attributes =>
      [:id, :question_id, :choice_ids=>[]])
  end

end

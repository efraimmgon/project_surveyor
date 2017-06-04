class QuestionsController < ApplicationController
  before_filter :save_last_url, :only => [:new]
  before_filter :get_last_url, :only => [:new]

  def new
    @survey = Survey.find(params[:survey_id])
    @survey_questions = @survey.questions
    @question = @survey.questions.build
    if params[:setup_done]
      n = params[:number_of_choices].to_i
      n.times{ |i| @question.choices.build }
      @setup_done = true
    end
  end

  def create
    @survey = Survey.find(params[:survey_id])
    if params[:setup_done]
      parameters = question_params.merge(session[:select_options])
      @question = @survey.questions.build(parameters)
      if @question.save
        redirect_to surveys_path
      else
        render :new
      end
    else
      parameters = {:setup_done => true,
                    :number_of_choices => params[:number_of_choices]}
      session[:select_options] = question_params
      redirect_to url_for([:new, @survey, :question, parameters])
    end
  end

  def destroy
    survey = Survey.find(params[:survey_id])
    question = Question.find(params[:id])
    if question.destroy
      redirect_to new_survey_question_path(survey.id)
    end
  end

  private

  def question_params
    params.require(:question).permit(:body, :input_type, :is_required,
      :survey_id, :choices_attributes => [:body])
  end

  def save_last_url
    session[:last_url] = request.env["HTTP_REFERER"]
  end

  def get_last_url
    @last_url = session[:last_url]
  end

end

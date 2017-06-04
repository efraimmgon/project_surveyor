class SurveysController < ApplicationController

  def index
    @surveys = Survey.all
    @surveys_responses = @surveys.joins(:responses).group("surveys.id").count.to_h
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to url_for([:new, @survey, :question])
    else
      render :new
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:title, :description)
  end

end

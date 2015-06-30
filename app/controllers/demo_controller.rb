class DemoController < ApplicationController

	layout false

  def index
  	#render('hello')
  end

  def hello
  	#render('index')

  	@array = [1,2,3,4,5]
  	@id = params['id'].to_i
  	@page = params[:page].to_i

  end

  def other_hello
  	redirect_to(:controller => 'demo', :action => 'index')
  end

  def sinocloud
  	redirect_to("http://sinocloud.technology")
  end

end

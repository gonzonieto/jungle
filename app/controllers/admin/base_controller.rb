class Admin::BaseController < ApplicationController

  self.abstract!

  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PW']
  
end
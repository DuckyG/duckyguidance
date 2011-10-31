class AuthorizedController < ApplicationController
  before_filter :authenticate_user_against_school!
  load_and_authorize_resource
end

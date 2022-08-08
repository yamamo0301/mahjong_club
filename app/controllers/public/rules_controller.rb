class Public::RulesController < ApplicationController
  def index
    @rules = current_user.rules.all
  end
end

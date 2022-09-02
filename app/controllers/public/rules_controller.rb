class Public::RulesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @rules = current_user.rules.all
    @rule = current_user.rules.new
  end

  def create
    @rule = current_user.rules.new(rule_params)
    if @rule.save
      flash[:notice] = '新しいルールを追加しました。'
      redirect_to rules_path
    else
      render :index
    end
  end

  def edit
    @rules = current_user.rules.all
    @rule = current_user.rules.find(params[:id])
  end

  def update
    @rule = current_user.rules.find(params[:id])
    if @rule.update(rule_params)
      flash[:notice] = 'ルールを更新しました。'
      redirect_to rules_path
    else
      render :edit
    end
  end


  private

  def rule_params
    params.require(:rule).permit(:name, :tip_point, :table_point, :calculation_status)
  end
end

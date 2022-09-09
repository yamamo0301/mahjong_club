class Form::Base
  # 継承先で使いたいクラスやメソッドの為に記述。
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
end
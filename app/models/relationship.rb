class Relationship < ApplicationRecord
  # class_nameがないと、followerテーブルとfollowedテーブルを探しに行ってしまう。しかしその２つテーブルは存在しない。
  # なのでclass_name: "User"でUserモデルを参照。usersテーブルからデータを取得。
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end

json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :description, :user_id, :fixed, :start_date, :task_cat_img_num
  json.url task_url(task, format: :json)
end

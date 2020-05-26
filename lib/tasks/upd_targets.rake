namespace :update_targets do
  desc "generate search suggestions from statements"
  task update: :environment do
    Tgroup.all.each do |tg|
      puts "tg #{tg.name}"
      tg.targets.each do |t|
        puts "t #{t.name} - #{t.group_id}"
        t.update_attribute(:group_id, tg.id) if t.group_id.nil?
      end
    end
  end
end
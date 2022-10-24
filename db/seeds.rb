# frozen_string_literal: true

require 'faker'

Bug.destroy_all
Project.destroy_all
User.destroy_all

5.times do |n|
  User.create!(
    name: "Manager #{n + 1}",
    email: "manager#{n + 1}@gmail.com",
    user_type: :manager,
    password: ENV.fetch('Manager_Pass', '123123'),
    password_confirmation: ENV.fetch('Manager_Pass', '123123'),
    confirmed_at: Time.zone.now
  )
  User.create!(
    name: "Developer #{n + 1}",
    email: "dev#{n + 1}@gmail.com",
    user_type: :dev,
    password: ENV.fetch('Dev_Pass', '123123'),
    password_confirmation: ENV.fetch('Dev_Pass', '123123'),
    confirmed_at: Time.zone.now
  )
  User.create!(
    name: "QA #{n + 1}",
    email: "qa#{n + 1}@gmail.com",
    user_type: :qa,
    password: ENV.fetch('QA_Pass', '123123'),
    password_confirmation: ENV.fetch('QA_Pass', '123123'),
    confirmed_at: Time.zone.now
  )
end

10.times do
  Project.create!(
    title: Faker::Name.unique.name,
    creator_id: User.manager.ids.sample
  )
end

30.times do
  Bug.create!(
    title: Faker::Name.unique.name,
    deadline: Faker::Date.forward(days: 23),
    bug_type: [0, 1].sample,
    status: 0,
    user_id: User.qa.ids.sample,
    project_id: Project.ids.sample
  )
end

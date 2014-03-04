FactoryGirl.define do
	factory :user do
		name "Alex Hendricks"
		email "alex@hendricksmail.com"
		password "foobar"
		password_confirmation "foobar"
	end
end
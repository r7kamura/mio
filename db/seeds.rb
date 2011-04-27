madoka_data = {:screen_name => "madoka", :email => "madoka@magica.qb", :profile_image_url => "http://example.com/madoka.png"}
madoka = User.where(madoka_data).first || User.create(madoka_data)

sayaka_data = {:screen_name => "sayaka", :email => "sayaka@magica.qb", :profile_image_url => "http://example.com/sayaka.png"}
sayaka = User.where(sayaka_data).first || User.create(sayaka_data)

homura_data = {:screen_name => "homura", :email => "homura@magica.qb", :profile_image_url => "http://example.com/homura.png"}
homura = User.where(homura_data).first || User.create(homura_data)


("a".."z").each.with_index do |c, i|
  case i % 3
  when 0
    madoka.tweet(c * 5)
  when 1
    sayaka.tweet(c * 5)
  when 2
    homura.tweet(c * 5)
  end
end

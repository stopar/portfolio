class SitesController < ApplicationController
  def home
  end

  def csv_sample
    send_file '#{Rails.root}/public/', filename: "sample_member_list.csv", type: 'text/csv', x_sendfile: true
  end
end

json.array!(@items) do |item|
  json.extract! item, :id, :client, :client_info, :subject, :description, :status, :proceedings, :notes, :initial_price, :running_price, :start_date, :end_date, :delivery, :introducer
  json.url item_url(item, format: :json)
end

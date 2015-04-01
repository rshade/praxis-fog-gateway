define log($api_server,$message) do
  $response = http_post(
    url: join([$api_server,"/api/log"]),
    body: {
      "message": $message
    },
    headers: { "Content-Type": "application/json",
               "X-Api-Version": "1.0"
             }
  )
  $body = $response["body"]
end

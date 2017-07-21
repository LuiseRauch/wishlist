module UrlHelper

  class AmazonAPI
    # The region you are interested in
    ENDPOINT = "webservices.amazon.de"
    REQUEST_URI = "/onca/xml"

    def search_by_asin(asin)
      params = {
        "Service" => "AWSECommerceService",
        "Operation" => "ItemLookup",
        "AWSAccessKeyId" => ENV['AWS_ACCESS_KEY_ID'],
        "AssociateTag" => ENV['AWS_ASSOCIATES_TAG'],
        "ItemId" => asin,
        "IdType" => "ASIN",
        "ResponseGroup" => "Images",
      }
      generate_request_url(params)
    end

    def generate_request_url(params)
      # Set current timestamp if not set
      params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")
      # Generate the canonical query
      canonical_query_string = params.sort.collect do |key, value|
        [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")),
         URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
      end.join('&')
      # Generate the string to be signed
      string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"
      # Generate the signature required by the Product Advertising API
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'),
        ENV['AWS_SECRET_KEY'], string_to_sign)).strip()
      # Generate the signed URL
      request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature,
        Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
    end
  end

  def is_amazon_url(url)
    /(?:www.)?ama?zo?n.(?:com|ca|co.uk|co.jp|de|fr)/.match?(url)
  end

  def get_asin(url)
    asin = url.scan(/[A-Z0-9]{10}/)
  end

  def display(url)
    if is_amazon_url(url)
      item = AmazonAPI.new.search_by_asin(get_asin(url)[0])
      results = HTTParty.get(item)
      !(results["ItemLookupResponse"]["Items"]["Request"]["Errors"]) ?
        results["ItemLookupResponse"]["Items"]["Item"]["LargeImage"]["URL"] : nil
    else
      MetaInspector.new(url, :allow_redirections => false).images.best
    end
  end

end

require 'awspec'

describe route53_hosted_zone('cohortscdi-five.com.') do
  it { should exist }
end

describe route53_hosted_zone('dev.cohortscdi-five.com.') do
  it { should exist }
end

describe route53_hosted_zone('qa.cohortscdi-five.com.') do
  it { should exist }
end

describe route53_hosted_zone('nonprod-us-east-2.cohortscdi-five.com.') do
  it { should exist }
end

describe route53_hosted_zone('prod.cohortscdi-five.com.') do
  it { should exist }
end

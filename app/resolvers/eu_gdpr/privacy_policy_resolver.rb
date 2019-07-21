module EuGdpr
  class PrivacyPolicyResolver < Ecm::Cms::PageResolver
  end
end if Gem.loaded_specs["ecm_cms"].present? || Gem.loaded_specs["ecm_cms2"].present?

module EuGdpr
  class PrivacyPolicyResolver < Cmor::Cms::PageResolver
  end
end if Gem.loaded_specs["cmor_cms"].present?
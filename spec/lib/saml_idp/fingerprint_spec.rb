require 'spec_helper'

module SamlIdp
  describe Fingerprint do
    describe "certificate_digest" do
      let(:cert) { sp_x509_cert }

      it "returns a SHA1 fingerprint" do
        fingerprint = Fingerprint.certificate_digest(cert, :sha1)
        expect(fingerprint).to match(/\A([0-9a-f]{2}:){19}[0-9a-f]{2}\z/)
      end

      it "returns a SHA256 fingerprint" do
        expected = "a2:cb:f6:6b:bc:2a:33:b9:4f:f3:c3:7e:26:a4:21:cd:41:83:ef:26:88:fa:ba:71:37:40:07:3e:d5:76:04:b7"
        expect(Fingerprint.certificate_digest(cert, :sha256)).to eq(expected)
      end

      it "returns a SHA512 fingerprint" do
        fingerprint = Fingerprint.certificate_digest(cert, :sha512)
        expect(fingerprint).to match(/\A([0-9a-f]{2}:){63}[0-9a-f]{2}\z/)
      end

      it "raises for unsupported algorithms" do
        expect { Fingerprint.certificate_digest(cert, :md5) }.to raise_error(ArgumentError, /Unsupported sha size parameter/)
      end
    end
  end
end

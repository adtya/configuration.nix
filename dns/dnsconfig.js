var DOMAIN_REGISTRAR = NewRegistrar("dynadot");

var DNS_PROVIDER_HETZNER = NewDnsProvider("hetzner");
var DNS_PROVIDER_DIGITALOCEAN = NewDnsProvider("digitalocean");

var DNS_PROVIDER_ONE = DnsProvider(DNS_PROVIDER_HETZNER);
var DNS_PROVIDER_TWO = DnsProvider(DNS_PROVIDER_DIGITALOCEAN, 0);

D(
  "adtya.xyz",
  DOMAIN_REGISTRAR,
  DNS_PROVIDER_ONE,
  DNS_PROVIDER_TWO,
  NAMESERVER_TTL("1d"),
  DefaultTTL("900s"),
  TXT("_github-pages-challenge-adtya", "c83b7cfc33c02c0499d401da51b801"),
  TXT("_atproto", "did=did:plc:4qhsxvly7gyyu42pow7mqkye"),
  CNAME("if3", "if3.fly.dev."),
  A("@", "134.209.147.152"),
  A("www", "134.209.147.152"),
  CNAME("wiki", "bifrost.ironyofprivacy.org."),
  CNAME("proofs", "bifrost.ironyofprivacy.org."),
  END,
);

D(
  "ironyofprivacy.org",
  DOMAIN_REGISTRAR,
  DNS_PROVIDER_ONE,
  DNS_PROVIDER_TWO,
  NAMESERVER_TTL("1d"),
  DefaultTTL("900s"),
  A("@", "134.209.147.152"),
  A("bifrost", "134.209.147.152"),
  CNAME("matrix", "bifrost.ironyofprivacy.org."),
  CNAME("notify", "bifrost.ironyofprivacy.org."),
  END,
);

function SETUP_FASTMAIL(domain) {
  D_EXTEND(
    domain,
    DefaultTTL("900s"),
    MX("@", 10, "in1-smtp.messagingengine.com."),
    MX("@", 20, "in2-smtp.messagingengine.com."),
    CNAME("mesmtp._domainkey", "mesmtp." + domain + ".dkim.fmhosted.com."),
    CNAME("fm1._domainkey", "fm1." + domain + ".dkim.fmhosted.com."),
    CNAME("fm2._domainkey", "fm2." + domain + ".dkim.fmhosted.com."),
    CNAME("fm3._domainkey", "fm3." + domain + ".dkim.fmhosted.com."),
    SRV("_submission._tcp", 0, 0, 0, "."),
    SRV("_imap._tcp", 0, 0, 0, "."),
    SRV("_pop3._tcp", 0, 0, 0, "."),
    SRV("_submissions._tcp", 0, 1, 465, "smtp.fastmail.com."),
    SRV("_imaps._tcp", 0, 1, 993, "imap.fastmail.com."),
    SRV("_pop3s._tcp", 10, 1, 995, "pop.fastmail.com."),
    SRV("_jmap._tcp", 0, 1, 443, "api.fastmail.com."),
    SRV("_autodiscover._tcp", 0, 1, 443, "autodiscover.fastmail.com."),
    SRV("_carddav._tcp", 0, 0, 0, "."),
    SRV("_carddavs._tcp", 0, 1, 443, "carddav.fastmail.com."),
    SRV("_caldav._tcp", 0, 0, 0, "."),
    SRV("_caldavs._tcp", 0, 1, 443, "caldav.fastmail.com."),
    TXT("@", "v=spf1 include:spf.messagingengine.com ?all"),
    TXT(
      "_dmarc",
      "v=DMARC1; p=reject; rua=mailto:dmarc_reports@" +
        domain +
        "; ruf=mailto:dmarc_reports@" +
        domain +
        ";",
    ),
    END,
  );
}

SETUP_FASTMAIL("adtya.xyz");
SETUP_FASTMAIL("ironyofprivacy.org");

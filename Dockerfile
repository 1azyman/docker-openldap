FROM alpine:latest

WORKDIR /opt

RUN apt-get update && apt-get install -y wget unzip
RUN wget https://github.com/Evolveum/slapdconf/archive/master.zip
RUN unzip master.zip

FROM osixia/openldap:1.1.10

WORKDIR /opt

COPY --from=0 /opt/slapdconf-master ./slapdconf

RUN slapdconf add-module sssvlv
#RUN slapdconf add-overlay $LDAP_BASE_DN sssvlv
#
#RUN slapdconf add-module ppolicy
#RUN ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/ppolicy.ldif
#RUN slapdconf add-overlay $LDAP_BASE_DN ppolicy
#
#RUN slapdconf add-module memberof
#RUN slapdconf add-overlay $LDAP_BASE_DN memberof
#
#RUN slapdconf add-module refint
#RUN slapdconf  add-overlay $LDAP_BASE_DN refint olcRefintConfig 'olcRefintAttribute:memberof member manager owner'
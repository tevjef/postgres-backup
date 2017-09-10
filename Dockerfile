FROM golang:1-alpine

RUN apk --no-cache add ca-certificates git openssl postgresql \                                                                                                                                                                                                      
&&  update-ca-certificates \
&&  go get github.com/tevjef/gcsupload

COPY upload.sh /upload.sh

CMD ["/upload.sh"]
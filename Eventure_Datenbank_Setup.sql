-- //////////////////// ERSTELLEN VON TABELLEN ////////////////////

create table password
(
    id   integer generated always as identity
        primary key,
    salt text not null,
    hash text not null
);

alter table password
    owner to eventuredb_user;

create table bild
(
    id   integer generated always as identity
        primary key,
    data text
);

alter table bild
    owner to eventuredb_user;

create table app_user
(
    id               integer generated always as identity
        constraint account_pkey
            primary key,
    benutzername     text    not null
        constraint benutzername
            unique,
    profilname       text    not null,
    email            text    not null
        constraint email
            unique,
    kurzbeschreibung text,
    beschreibung     text,
    region           text,
    password         integer not null
        constraint passwordfk
            references password,
    sterne           integer default 0,
    bildid           integer
        constraint profilfk
            references bild
);

alter table app_user
    owner to eventuredb_user;

create table location
(
    id               integer generated always as identity
        constraint "Location_pkey"
            primary key,
    adresse          text                 not null,
    name             text                 not null,
    beschreibung     text,
    ownerid          integer
        constraint "ownderID"
            references app_user,
    privat           boolean default true not null,
    kurzbeschreibung text,
    preis            text                 not null,
    openair          boolean              not null,
    flaeche          text                 not null,
    kapazitaet       integer              not null,
    sterne           integer default 0,
    bildid           integer
        constraint bildfk
            references bild
);

alter table location
    owner to eventuredb_user;

create table endnutzer
(
    emailfk text    not null
        constraint email_unique
            unique
        constraint "emailFK"
            references app_user (email),
    alter   integer not null,
    arten   text,
    lied    text,
    gericht text,
    id      integer generated always as identity
        primary key
);

alter table endnutzer
    owner to eventuredb_user;

create table artist
(
    emailfk   text not null
        constraint artist_email_unique
            unique
        constraint "emailFK"
            references app_user (email),
    preis     text not null,
    kategorie text,
    erfahrung text,
    id        integer generated always as identity
        primary key
);

alter table artist
    owner to eventuredb_user;

create table lied
(
    id          integer generated always as identity
        constraint "Song_pkey"
            primary key,
    ownerid     integer not null
        constraint ownerid
            references artist,
    name        text    not null,
    laenge      numeric not null,
    erscheinung date    not null
);

comment on column lied.laenge is 'Length in Seconds';

comment on column lied.erscheinung is 'YYYY-MM-DD';

alter table lied
    owner to eventuredb_user;

create table caterer
(
    emailfk   text not null
        constraint caterer_email_unique
            unique
        constraint "emailFK"
            references app_user (email),
    preis     text not null,
    kategorie text,
    erfahrung text,
    id        integer generated always as identity
        primary key
);

alter table caterer
    owner to eventuredb_user;

create table gericht
(
    id           integer generated always as identity
        constraint "Dish_pkey"
            primary key,
    ownerid      integer not null
        constraint ownerid
            references caterer,
    name         text    not null,
    beschreibung text    not null,
    bildid       integer
        constraint bildfk
            references bild
);

alter table gericht
    owner to eventuredb_user;

create table event
(
    id               integer generated always as identity
        primary key,
    name             text                                               not null
        constraint "Name_checkSize"
            check (length(name) <= 25),
    datum            date                                               not null,
    eventgroesse     integer                                            not null,
    freietickets     integer                                            not null,
    preis            text                                               not null,
    altersfreigabe   integer                                            not null,
    privat           boolean                                            not null,
    kurzbeschreibung text,
    beschreibung     text,
    ownerid          integer                                            not null
        constraint "ownerID"
            references app_user,
    locationid       integer
        constraint locationid
            references location,
    sterne           integer default 0,
    maxtickets       integer default 0                                  not null,
    bildid           integer
        constraint bildfk
            references bild,
    startuhrzeit     time    default '00:00:00'::time without time zone not null,
    enduhrzeit       time    default '00:00:00'::time without time zone not null,
    dauer            time    default '00:00:00'::time without time zone,
    isvalid          boolean default false
);

alter table event
    owner to eventuredb_user;

create table review
(
    id         integer generated always as identity
        primary key,
    inhalt     text    not null,
    sterne     integer not null
        constraint "sterneConstraint"
            check ((sterne >= 1) AND (sterne <= 5)),
    ownerid    integer not null
        constraint "ownerID"
            references app_user,
    eventid    integer
        constraint "eventID"
            references event,
    userid     integer
        constraint "userID"
            references app_user,
    locationid integer,
    constraint "eventORuserORlocation"
        check (((eventid IS NOT NULL) AND (userid IS NULL) AND (locationid IS NULL)) OR
               ((eventid IS NULL) AND (userid IS NOT NULL) AND (locationid IS NULL)) OR
               ((eventid IS NULL) AND (userid IS NULL) AND (locationid IS NOT NULL)))
);

alter table review
    owner to eventuredb_user;



create table tickets
(
    userid  integer not null
        constraint userid
            references app_user,
    eventid integer not null
        constraint eventid
            references event,
    id      integer generated always as identity
        primary key,
    data    text    not null
);

comment on table tickets is 'Zeigt welcher User an welchem Event teilnimmt.';

alter table tickets
    owner to eventuredb_user;

create table serviceartist
(
    id       integer generated always as identity
        primary key,
    eventid  integer not null
        constraint eventid
            references event,
    artistid integer not null
        constraint artistid
            references artist,
    accepted boolean default false
);

alter table serviceartist
    owner to eventuredb_user;

create table servicecaterer
(
    id        integer generated always as identity
        primary key,
    eventid   integer not null
        constraint eventid
            references event,
    catererid integer not null
        constraint catererid
            references caterer,
    accepted  boolean default false
);

alter table servicecaterer
    owner to eventuredb_user;

create table favorit_location
(
    id         integer generated always as identity
        primary key,
    userid     integer not null
        constraint useridfk
            references app_user,
    locationid integer not null
        constraint locationidfk
            references location
);

alter table favorit_location
    owner to eventuredb_user;

create table favorit_user
(
    userid    integer not null,
    enduserid integer
        constraint enduserid
            references endnutzer,
    id        integer generated always as identity
        constraint id
            primary key,
    artistid  integer
        constraint artistid
            references artist,
    catereid  integer
        constraint catere
            references caterer,
    constraint "enduserORartistOrcatere"
        check (((artistid IS NOT NULL) AND (catereid IS NULL) AND (enduserid IS NULL)) OR
               ((artistid IS NULL) AND (catereid IS NOT NULL) AND (enduserid IS NULL)) OR
               ((artistid IS NULL) AND (catereid IS NULL) AND (enduserid IS NOT NULL)))
);

alter table favorit_user
    owner to eventuredb_user;

create table favorit_event
(
    id      integer generated always as identity
        primary key,
    userid  integer not null
        constraint userid
            references app_user,
    eventid integer not null
        constraint eventid
            references event
);

alter table favorit_event
    owner to eventuredb_user;

create table mail
(
    id         integer generated always as identity
        primary key,
    sender     integer               not null
        constraint senderfk
            references app_user,
    empfaenger integer               not null
        constraint empfaengerfk
            references app_user,
    gelesen    boolean default false not null,
    eventid    integer
        constraint eventfk
            references event,
    angenommen boolean,
    anfrage    text                  not null
        constraint "anfrageType"
            check (anfrage = ANY
                   (ARRAY ['location'::text, 'service'::text, 'freundschaft'::text, 'info'::text, 'ticket'::text])),
    ticketid   integer
);

comment on column mail.eventid is 'Die Mail wird an Caterer/Artists/Locationinhaber gesendet. Wird die Anfrage angenommen, wird der Empfänger dann zum Event hinzugefügt.';

comment on column mail.angenommen is 'Anfangs null, dann true or false wenn angenommen oder nicht';

alter table mail
    owner to eventuredb_user;

create table partybilder
(
    id     integer generated always as identity
        primary key,
    userid integer not null
        constraint userid
            references app_user,
    bildid integer not null
        constraint bildid
            references bild
);

alter table partybilder
    owner to eventuredb_user;

create table friend
(
    id    integer generated always as identity
        primary key,
    user1 integer not null
        constraint user1
            references app_user,
    user2 integer not null
        constraint user2
            references app_user,
    constraint "notSelfFriend"
        check (user1 <> user2)
);

alter table friend
    owner to eventuredb_user;

-- //////////////////// ERSTELLEN VON TRIGGER FUNCTIONS ////////////////////

create trigger "InsertTicket"
    after insert or update
    on tickets
    for each row
execute procedure "InsertTicket"();

create trigger "DeleteTicket"
    after update or delete
    on tickets
    for each row
execute procedure "DeleteTicket"();

create trigger "updateuser_AVG"
    after insert or update or delete
    on review
    for each row
execute procedure "updateUser_AVG"();

create trigger "updateevent_AVG"
    after insert or update
    on review
    for each row
execute procedure "updateEvent_AVG"();

create trigger updatelocation_avg
    after insert or update
    on review
    for each row
execute procedure "updateLocation_AVG"();

create trigger "deleteUser_AVG"
    after delete
    on review
    for each row
execute procedure "deleteUser_AVG"();

create trigger "deleteLocation_AVG"
    after delete
    on review
    for each row
execute procedure "deletLocation_AVG"();

create trigger "deleteEvent_AVG"
    after delete
    on review
    for each row
execute procedure "deleteEvent_AVG"();
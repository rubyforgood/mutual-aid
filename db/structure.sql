SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'neighbor',
    'volunteer',
    'dispatcher',
    'admin',
    'sys_admin'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    id bigint NOT NULL,
    name character varying,
    description text,
    publish_from date,
    publish_until date,
    is_approved boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcements_id_seq OWNED BY public.announcements.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying NOT NULL,
    description character varying,
    display_to_public boolean DEFAULT true NOT NULL,
    display_order integer DEFAULT 10 NOT NULL,
    is_created_by_admin boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: communication_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communication_logs (
    id bigint NOT NULL,
    person_id bigint,
    match_id bigint,
    sent_at timestamp without time zone,
    needs_follow_up boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    delivery_status character varying,
    subject character varying,
    created_by_id bigint DEFAULT 1 NOT NULL,
    body character varying,
    outbound boolean DEFAULT true NOT NULL,
    delivery_method_id bigint NOT NULL,
    auto_generated boolean DEFAULT false
);


--
-- Name: communication_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.communication_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communication_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.communication_logs_id_seq OWNED BY public.communication_logs.id;


--
-- Name: community_resources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_resources (
    id bigint NOT NULL,
    service_area_id bigint,
    location_id bigint,
    organization_id bigint,
    name character varying,
    website_url character varying,
    facebook_url character varying,
    phone character varying,
    description character varying,
    publish_from date,
    publish_until date,
    is_created_by_admin boolean DEFAULT true NOT NULL,
    is_approved boolean DEFAULT true NOT NULL,
    youtube_identifier character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tags character varying[] DEFAULT '{}'::character varying[]
);


--
-- Name: community_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_resources_id_seq OWNED BY public.community_resources.id;


--
-- Name: contact_methods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_methods (
    id bigint NOT NULL,
    name character varying,
    field character varying,
    enabled boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    icon_class character varying
);


--
-- Name: contact_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contact_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contact_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contact_methods_id_seq OWNED BY public.contact_methods.id;


--
-- Name: custom_form_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_form_questions (
    id bigint NOT NULL,
    name character varying,
    input_type character varying,
    is_required boolean DEFAULT true NOT NULL,
    form_type character varying,
    option_list text[] DEFAULT '{}'::text[],
    hint_text character varying,
    display_order character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    form_hook character varying
);


--
-- Name: custom_form_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_form_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_form_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_form_questions_id_seq OWNED BY public.custom_form_questions.id;


--
-- Name: donations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.donations (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    value double precision,
    channel character varying,
    thank_you_sent character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: donations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.donations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: donations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.donations_id_seq OWNED BY public.donations.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedbacks (
    id bigint NOT NULL,
    match_id bigint NOT NULL,
    is_from_receiver boolean DEFAULT true NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    quality integer,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: history_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.history_logs (
    id bigint NOT NULL,
    topic character varying,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: history_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.history_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: history_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.history_logs_id_seq OWNED BY public.history_logs.id;


--
-- Name: listings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.listings (
    id bigint NOT NULL,
    title character varying,
    description text,
    type character varying,
    state integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tags text[] DEFAULT '{}'::text[],
    person_id bigint NOT NULL,
    service_area_id bigint NOT NULL,
    location_id bigint,
    submission_id bigint,
    urgency_level_id bigint
);


--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.listings_id_seq OWNED BY public.listings.id;


--
-- Name: location_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.location_types (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    display_to_public boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: location_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.location_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: location_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.location_types_id_seq OWNED BY public.location_types.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    street_address character varying,
    city character varying,
    state character varying(2),
    zip character varying(5),
    county character varying,
    region character varying,
    neighborhood character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    location_type_id bigint NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    id bigint NOT NULL,
    provider_id integer,
    provider_type character varying,
    receiver_type character varying,
    receiver_id integer,
    status character varying,
    notes character varying,
    tentative boolean DEFAULT true NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    exchanged_at timestamp without time zone
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: mobility_string_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mobility_string_translations (
    id bigint NOT NULL,
    locale character varying NOT NULL,
    key character varying NOT NULL,
    value character varying,
    translatable_type character varying,
    translatable_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    created_by_id bigint,
    is_approved boolean DEFAULT true NOT NULL
);


--
-- Name: mobility_string_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mobility_string_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mobility_string_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mobility_string_translations_id_seq OWNED BY public.mobility_string_translations.id;


--
-- Name: mobility_text_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mobility_text_translations (
    id bigint NOT NULL,
    locale character varying NOT NULL,
    key character varying NOT NULL,
    value text,
    translatable_type character varying,
    translatable_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    created_by_id bigint,
    is_approved boolean DEFAULT true NOT NULL
);


--
-- Name: mobility_text_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mobility_text_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mobility_text_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mobility_text_translations_id_seq OWNED BY public.mobility_text_translations.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying,
    short_name character varying,
    description character varying,
    facebook_url character varying,
    website_url character varying,
    phone character varying,
    is_instance_owner boolean DEFAULT true NOT NULL,
    has_sms_account boolean DEFAULT false NOT NULL,
    has_hosting_account boolean DEFAULT false NOT NULL,
    has_mailer_account boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    location_id bigint,
    service_area_id bigint,
    display_on_org_chart boolean DEFAULT true NOT NULL,
    logo_url character varying,
    favicon_url character varying
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id bigint NOT NULL,
    name character varying,
    phone character varying,
    email character varying,
    phone_2 character varying,
    email_2 character varying,
    preferred_contact_timeframe character varying,
    skills text,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    location_id bigint,
    service_area_id bigint,
    user_id bigint,
    preferred_locale character varying DEFAULT 'en'::character varying NOT NULL,
    monthly_matches_max integer DEFAULT 0,
    monthly_donation_amount_max double precision DEFAULT 0.0,
    preferred_contact_method_id integer
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.positions (
    id bigint NOT NULL,
    person_id bigint,
    organization_id bigint,
    position_type character varying,
    name character varying,
    description character varying,
    start_date date,
    end_date date,
    is_primary boolean DEFAULT false NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    team_id bigint,
    display_on_org_chart boolean DEFAULT true NOT NULL
);


--
-- Name: positions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.positions_id_seq OWNED BY public.positions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: service_areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_areas (
    id bigint NOT NULL,
    parent_id bigint,
    organization_id bigint,
    service_area_type character varying,
    name character varying,
    description character varying,
    display_to_public boolean DEFAULT true NOT NULL,
    display_order integer DEFAULT 10 NOT NULL,
    is_created_by_admin boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    location_id bigint NOT NULL
);


--
-- Name: service_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.service_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: service_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_areas_id_seq OWNED BY public.service_areas.id;


--
-- Name: shared_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shared_accounts (
    id bigint NOT NULL,
    name character varying,
    account_url character varying,
    username character varying,
    password_hint character varying,
    notes character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: shared_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shared_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shared_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shared_accounts_id_seq OWNED BY public.shared_accounts.id;


--
-- Name: shift_matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shift_matches (
    id bigint NOT NULL,
    shift_id bigint NOT NULL,
    match_id bigint NOT NULL,
    notes character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: shift_matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shift_matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shift_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shift_matches_id_seq OWNED BY public.shift_matches.id;


--
-- Name: shifts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shifts (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    team_id bigint NOT NULL,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: shifts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shifts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shifts_id_seq OWNED BY public.shifts.id;


--
-- Name: software_feedbacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.software_feedbacks (
    id bigint NOT NULL,
    created_by_id bigint,
    feedback_type character varying,
    module_name character varying,
    page_url character varying,
    name character varying NOT NULL,
    urgency character varying,
    urgency_order integer,
    notes character varying,
    completed boolean DEFAULT false NOT NULL,
    completed_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: software_feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.software_feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: software_feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.software_feedbacks_id_seq OWNED BY public.software_feedbacks.id;


--
-- Name: submission_responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_responses (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    custom_form_question_id bigint NOT NULL,
    boolean_response boolean,
    date_response date,
    datetime_response timestamp without time zone,
    integer_response integer,
    text_response text,
    string_response character varying,
    array_response text[] DEFAULT '{}'::text[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: submission_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submission_responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submission_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submission_responses_id_seq OWNED BY public.submission_responses.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submissions (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    service_area_id bigint NOT NULL,
    form_name character varying,
    privacy_level_requested character varying,
    body text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: system_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_locales (
    id bigint NOT NULL,
    locale character varying NOT NULL,
    locale_name character varying NOT NULL,
    publish_in_dropdowns boolean DEFAULT true NOT NULL,
    publish_translations boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: system_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.system_locales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.system_locales_id_seq OWNED BY public.system_locales.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_settings (
    id bigint NOT NULL,
    exchange_type character varying DEFAULT 'peer_to_peer'::character varying NOT NULL,
    separate_asks_offers boolean DEFAULT true NOT NULL,
    community_resources_module boolean DEFAULT true NOT NULL,
    announcements_module boolean DEFAULT true NOT NULL,
    donations_module boolean DEFAULT true NOT NULL,
    positions_module boolean DEFAULT true NOT NULL,
    shared_accounts_module boolean DEFAULT true NOT NULL,
    allow_sms boolean DEFAULT false NOT NULL,
    chat_module boolean DEFAULT true NOT NULL,
    landing_page_text_what text,
    landing_page_text_who text,
    landing_page_text_how text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    about_us_text text,
    confirmation_page_text_header character varying,
    confirmation_page_text_body character varying,
    confirmation_page_text_link_header character varying,
    confirmation_page_text_footer character varying
);


--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.system_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_type character varying,
    taggable_id integer,
    tagger_type character varying,
    tagger_id integer,
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.taggings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.taggings_id_seq OWNED BY public.taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    taggings_count integer DEFAULT 0
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    organization_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    standing_meeting_schedule character varying,
    display_on_org_chart boolean DEFAULT true NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role public.user_role
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements ALTER COLUMN id SET DEFAULT nextval('public.announcements_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: communication_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_logs ALTER COLUMN id SET DEFAULT nextval('public.communication_logs_id_seq'::regclass);


--
-- Name: community_resources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_resources ALTER COLUMN id SET DEFAULT nextval('public.community_resources_id_seq'::regclass);


--
-- Name: contact_methods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_methods ALTER COLUMN id SET DEFAULT nextval('public.contact_methods_id_seq'::regclass);


--
-- Name: custom_form_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_form_questions ALTER COLUMN id SET DEFAULT nextval('public.custom_form_questions_id_seq'::regclass);


--
-- Name: donations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.donations ALTER COLUMN id SET DEFAULT nextval('public.donations_id_seq'::regclass);


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: history_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.history_logs ALTER COLUMN id SET DEFAULT nextval('public.history_logs_id_seq'::regclass);


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings ALTER COLUMN id SET DEFAULT nextval('public.listings_id_seq'::regclass);


--
-- Name: location_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_types ALTER COLUMN id SET DEFAULT nextval('public.location_types_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: mobility_string_translations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mobility_string_translations ALTER COLUMN id SET DEFAULT nextval('public.mobility_string_translations_id_seq'::regclass);


--
-- Name: mobility_text_translations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mobility_text_translations ALTER COLUMN id SET DEFAULT nextval('public.mobility_text_translations_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- Name: positions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions ALTER COLUMN id SET DEFAULT nextval('public.positions_id_seq'::regclass);


--
-- Name: service_areas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_areas ALTER COLUMN id SET DEFAULT nextval('public.service_areas_id_seq'::regclass);


--
-- Name: shared_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_accounts ALTER COLUMN id SET DEFAULT nextval('public.shared_accounts_id_seq'::regclass);


--
-- Name: shift_matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_matches ALTER COLUMN id SET DEFAULT nextval('public.shift_matches_id_seq'::regclass);


--
-- Name: shifts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shifts ALTER COLUMN id SET DEFAULT nextval('public.shifts_id_seq'::regclass);


--
-- Name: software_feedbacks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.software_feedbacks ALTER COLUMN id SET DEFAULT nextval('public.software_feedbacks_id_seq'::regclass);


--
-- Name: submission_responses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_responses ALTER COLUMN id SET DEFAULT nextval('public.submission_responses_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: system_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_locales ALTER COLUMN id SET DEFAULT nextval('public.system_locales_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings ALTER COLUMN id SET DEFAULT nextval('public.taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: communication_logs communication_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_pkey PRIMARY KEY (id);


--
-- Name: community_resources community_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_resources
    ADD CONSTRAINT community_resources_pkey PRIMARY KEY (id);


--
-- Name: contact_methods contact_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_methods
    ADD CONSTRAINT contact_methods_pkey PRIMARY KEY (id);


--
-- Name: custom_form_questions custom_form_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_form_questions
    ADD CONSTRAINT custom_form_questions_pkey PRIMARY KEY (id);


--
-- Name: donations donations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.donations
    ADD CONSTRAINT donations_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: history_logs history_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.history_logs
    ADD CONSTRAINT history_logs_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: location_types location_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_types
    ADD CONSTRAINT location_types_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: mobility_string_translations mobility_string_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mobility_string_translations
    ADD CONSTRAINT mobility_string_translations_pkey PRIMARY KEY (id);


--
-- Name: mobility_text_translations mobility_text_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mobility_text_translations
    ADD CONSTRAINT mobility_text_translations_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: service_areas service_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_areas
    ADD CONSTRAINT service_areas_pkey PRIMARY KEY (id);


--
-- Name: shared_accounts shared_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_accounts
    ADD CONSTRAINT shared_accounts_pkey PRIMARY KEY (id);


--
-- Name: shift_matches shift_matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_matches
    ADD CONSTRAINT shift_matches_pkey PRIMARY KEY (id);


--
-- Name: shifts shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_pkey PRIMARY KEY (id);


--
-- Name: software_feedbacks software_feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.software_feedbacks
    ADD CONSTRAINT software_feedbacks_pkey PRIMARY KEY (id);


--
-- Name: submission_responses submission_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_responses
    ADD CONSTRAINT submission_responses_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: system_locales system_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_locales
    ADD CONSTRAINT system_locales_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_categories_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_description ON public.categories USING btree (description);


--
-- Name: index_categories_on_display_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_display_order ON public.categories USING btree (display_order);


--
-- Name: index_categories_on_display_to_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_display_to_public ON public.categories USING btree (display_to_public);


--
-- Name: index_categories_on_is_created_by_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_is_created_by_admin ON public.categories USING btree (is_created_by_admin);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_name ON public.categories USING btree (name);


--
-- Name: index_categories_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_parent_id ON public.categories USING btree (parent_id);


--
-- Name: index_communication_logs_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_communication_logs_on_created_by_id ON public.communication_logs USING btree (created_by_id);


--
-- Name: index_communication_logs_on_delivery_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_communication_logs_on_delivery_method_id ON public.communication_logs USING btree (delivery_method_id);


--
-- Name: index_communication_logs_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_communication_logs_on_match_id ON public.communication_logs USING btree (match_id);


--
-- Name: index_communication_logs_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_communication_logs_on_person_id ON public.communication_logs USING btree (person_id);


--
-- Name: index_community_resources_on_is_approved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_resources_on_is_approved ON public.community_resources USING btree (is_approved);


--
-- Name: index_community_resources_on_is_created_by_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_resources_on_is_created_by_admin ON public.community_resources USING btree (is_created_by_admin);


--
-- Name: index_community_resources_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_resources_on_location_id ON public.community_resources USING btree (location_id);


--
-- Name: index_community_resources_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_resources_on_organization_id ON public.community_resources USING btree (organization_id);


--
-- Name: index_community_resources_on_service_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_resources_on_service_area_id ON public.community_resources USING btree (service_area_id);


--
-- Name: index_community_resources_on_tags; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_resources_on_tags ON public.community_resources USING gin (tags);


--
-- Name: index_contact_methods_on_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contact_methods_on_enabled ON public.contact_methods USING btree (enabled);


--
-- Name: index_donations_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_donations_on_person_id ON public.donations USING btree (person_id);


--
-- Name: index_feedbacks_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feedbacks_on_match_id ON public.feedbacks USING btree (match_id);


--
-- Name: index_listings_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_location_id ON public.listings USING btree (location_id);


--
-- Name: index_listings_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_person_id ON public.listings USING btree (person_id);


--
-- Name: index_listings_on_service_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_service_area_id ON public.listings USING btree (service_area_id);


--
-- Name: index_listings_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_submission_id ON public.listings USING btree (submission_id);


--
-- Name: index_listings_on_tags; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_tags ON public.listings USING gin (tags);


--
-- Name: index_listings_on_urgency_level_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_urgency_level_id ON public.listings USING btree (urgency_level_id);


--
-- Name: index_location_types_on_display_to_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_location_types_on_display_to_public ON public.location_types USING btree (display_to_public);


--
-- Name: index_locations_on_location_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_location_type_id ON public.locations USING btree (location_type_id);


--
-- Name: index_mobility_string_translations_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mobility_string_translations_on_created_by_id ON public.mobility_string_translations USING btree (created_by_id);


--
-- Name: index_mobility_string_translations_on_keys; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_mobility_string_translations_on_keys ON public.mobility_string_translations USING btree (translatable_id, translatable_type, locale, key);


--
-- Name: index_mobility_string_translations_on_query_keys; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mobility_string_translations_on_query_keys ON public.mobility_string_translations USING btree (translatable_type, key, value, locale);


--
-- Name: index_mobility_string_translations_on_translatable_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mobility_string_translations_on_translatable_attribute ON public.mobility_string_translations USING btree (translatable_id, translatable_type, key);


--
-- Name: index_mobility_text_translations_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mobility_text_translations_on_created_by_id ON public.mobility_text_translations USING btree (created_by_id);


--
-- Name: index_mobility_text_translations_on_keys; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_mobility_text_translations_on_keys ON public.mobility_text_translations USING btree (translatable_id, translatable_type, locale, key);


--
-- Name: index_mobility_text_translations_on_translatable_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mobility_text_translations_on_translatable_attribute ON public.mobility_text_translations USING btree (translatable_id, translatable_type, key);


--
-- Name: index_organizations_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_location_id ON public.organizations USING btree (location_id);


--
-- Name: index_organizations_on_service_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_service_area_id ON public.organizations USING btree (service_area_id);


--
-- Name: index_people_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_location_id ON public.people USING btree (location_id);


--
-- Name: index_people_on_service_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_service_area_id ON public.people USING btree (service_area_id);


--
-- Name: index_people_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_user_id ON public.people USING btree (user_id);


--
-- Name: index_positions_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_positions_on_organization_id ON public.positions USING btree (organization_id);


--
-- Name: index_positions_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_positions_on_person_id ON public.positions USING btree (person_id);


--
-- Name: index_positions_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_positions_on_team_id ON public.positions USING btree (team_id);


--
-- Name: index_service_areas_on_display_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_display_order ON public.service_areas USING btree (display_order);


--
-- Name: index_service_areas_on_display_to_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_display_to_public ON public.service_areas USING btree (display_to_public);


--
-- Name: index_service_areas_on_is_created_by_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_is_created_by_admin ON public.service_areas USING btree (is_created_by_admin);


--
-- Name: index_service_areas_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_location_id ON public.service_areas USING btree (location_id);


--
-- Name: index_service_areas_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_name ON public.service_areas USING btree (name);


--
-- Name: index_service_areas_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_organization_id ON public.service_areas USING btree (organization_id);


--
-- Name: index_service_areas_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_areas_on_parent_id ON public.service_areas USING btree (parent_id);


--
-- Name: index_shift_matches_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shift_matches_on_match_id ON public.shift_matches USING btree (match_id);


--
-- Name: index_shift_matches_on_shift_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shift_matches_on_shift_id ON public.shift_matches USING btree (shift_id);


--
-- Name: index_shifts_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shifts_on_person_id ON public.shifts USING btree (person_id);


--
-- Name: index_shifts_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shifts_on_team_id ON public.shifts USING btree (team_id);


--
-- Name: index_software_feedbacks_on_completed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_software_feedbacks_on_completed ON public.software_feedbacks USING btree (completed);


--
-- Name: index_software_feedbacks_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_software_feedbacks_on_created_by_id ON public.software_feedbacks USING btree (created_by_id);


--
-- Name: index_submission_responses_on_custom_form_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submission_responses_on_custom_form_question_id ON public.submission_responses USING btree (custom_form_question_id);


--
-- Name: index_submission_responses_on_string_response; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submission_responses_on_string_response ON public.submission_responses USING btree (string_response);


--
-- Name: index_submission_responses_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submission_responses_on_submission_id ON public.submission_responses USING btree (submission_id);


--
-- Name: index_submissions_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_person_id ON public.submissions USING btree (person_id);


--
-- Name: index_submissions_on_service_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_service_area_id ON public.submissions USING btree (service_area_id);


--
-- Name: index_system_locales_on_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_system_locales_on_locale ON public.system_locales USING btree (locale);


--
-- Name: index_system_locales_on_publish_in_dropdowns; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_system_locales_on_publish_in_dropdowns ON public.system_locales USING btree (publish_in_dropdowns);


--
-- Name: index_system_locales_on_publish_translations; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_system_locales_on_publish_translations ON public.system_locales USING btree (publish_translations);


--
-- Name: index_taggings_on_context; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_context ON public.taggings USING btree (context);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tag_id ON public.taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_id ON public.taggings USING btree (taggable_id);


--
-- Name: index_taggings_on_taggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_type ON public.taggings USING btree (taggable_type);


--
-- Name: index_taggings_on_tagger_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_id ON public.taggings USING btree (tagger_id);


--
-- Name: index_taggings_on_tagger_id_and_tagger_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_id_and_tagger_type ON public.taggings USING btree (tagger_id, tagger_type);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON public.tags USING btree (name);


--
-- Name: index_teams_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_teams_on_organization_id ON public.teams USING btree (organization_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_role ON public.users USING btree (role);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX taggings_idx ON public.taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: taggings_idy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggings_idy ON public.taggings USING btree (taggable_id, taggable_type, tagger_id, context);


--
-- Name: taggings_taggable_context_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggings_taggable_context_idx ON public.taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: positions fk_rails_096a6ce7d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT fk_rails_096a6ce7d3 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: shifts fk_rails_130afd03ad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT fk_rails_130afd03ad FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: people fk_rails_16b1123d8e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_rails_16b1123d8e FOREIGN KEY (service_area_id) REFERENCES public.service_areas(id);


--
-- Name: communication_logs fk_rails_1707903db7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT fk_rails_1707903db7 FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: community_resources fk_rails_198bcbb1a0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_resources
    ADD CONSTRAINT fk_rails_198bcbb1a0 FOREIGN KEY (service_area_id) REFERENCES public.service_areas(id);


--
-- Name: submission_responses fk_rails_24de42e5d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_responses
    ADD CONSTRAINT fk_rails_24de42e5d4 FOREIGN KEY (custom_form_question_id) REFERENCES public.custom_form_questions(id);


--
-- Name: submissions fk_rails_2b681b3209; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_2b681b3209 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: organizations fk_rails_40271a6430; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT fk_rails_40271a6430 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: listings fk_rails_610c68c55e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_610c68c55e FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: positions fk_rails_6348fbb073; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT fk_rails_6348fbb073 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: shift_matches fk_rails_759089ae69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_matches
    ADD CONSTRAINT fk_rails_759089ae69 FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: donations fk_rails_776e99a61e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.donations
    ADD CONSTRAINT fk_rails_776e99a61e FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: service_areas fk_rails_7bbe0d6b71; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_areas
    ADD CONSTRAINT fk_rails_7bbe0d6b71 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: listings fk_rails_7c4c59488b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_7c4c59488b FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: feedbacks fk_rails_82bd7596d6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT fk_rails_82bd7596d6 FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: listings fk_rails_839efab3f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_839efab3f7 FOREIGN KEY (service_area_id) REFERENCES public.service_areas(id);


--
-- Name: shift_matches fk_rails_8c4a367253; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_matches
    ADD CONSTRAINT fk_rails_8c4a367253 FOREIGN KEY (shift_id) REFERENCES public.shifts(id);


--
-- Name: taggings fk_rails_9fcd2e236b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT fk_rails_9fcd2e236b FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- Name: locations fk_rails_a13c883eb0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT fk_rails_a13c883eb0 FOREIGN KEY (location_type_id) REFERENCES public.location_types(id);


--
-- Name: submissions fk_rails_a2293d8ba8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_a2293d8ba8 FOREIGN KEY (service_area_id) REFERENCES public.service_areas(id);


--
-- Name: submission_responses fk_rails_a5c8cd7a07; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_responses
    ADD CONSTRAINT fk_rails_a5c8cd7a07 FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: people fk_rails_b39dcee1e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_rails_b39dcee1e8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: organizations fk_rails_b41185b2ae; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT fk_rails_b41185b2ae FOREIGN KEY (service_area_id) REFERENCES public.service_areas(id);


--
-- Name: listings fk_rails_be1fc536fd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_be1fc536fd FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: communication_logs fk_rails_d368131718; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT fk_rails_d368131718 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: service_areas fk_rails_d3dde3cc9e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_areas
    ADD CONSTRAINT fk_rails_d3dde3cc9e FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: positions fk_rails_d8d36e9590; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT fk_rails_d8d36e9590 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: people fk_rails_ee55dd5e09; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_rails_ee55dd5e09 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: teams fk_rails_f07f0bd66d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT fk_rails_f07f0bd66d FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: community_resources fk_rails_f6fef234c9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_resources
    ADD CONSTRAINT fk_rails_f6fef234c9 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: community_resources fk_rails_f801f8a084; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_resources
    ADD CONSTRAINT fk_rails_f801f8a084 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: shifts fk_rails_ffd299a5dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT fk_rails_ffd299a5dd FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200325015725'),
('20200331004737'),
('20200331013236'),
('20200331162815'),
('20200331164343'),
('20200414140907'),
('20200414141059'),
('20200414141311'),
('20200415014559'),
('20200415020109'),
('20200415020209'),
('20200415020210'),
('20200415021948'),
('20200415033652'),
('20200415033654'),
('20200416141308'),
('20200416141310'),
('20200416145123'),
('20200419101332'),
('20200419101333'),
('20200427122237'),
('20200428233605'),
('20200428233606'),
('20200430203728'),
('20200501210525'),
('20200501210530'),
('20200501210535'),
('20200503221658'),
('20200503222220'),
('20200503224311'),
('20200505095309'),
('20200505121258'),
('20200508012027'),
('20200508031249'),
('20200508194010'),
('20200509052637'),
('20200509054235'),
('20200509181358'),
('20200509192814'),
('20200510004011'),
('20200510023122'),
('20200510025535'),
('20200510032817'),
('20200510043912'),
('20200510043913'),
('20200510043914'),
('20200510043915'),
('20200510043916'),
('20200510043917'),
('20200511014005'),
('20200511213733'),
('20200513015136'),
('20200513031357'),
('20200514013541'),
('20200514101411'),
('20200514102503'),
('20200514121433'),
('20200514122030'),
('20200515031229'),
('20200515035041'),
('20200516190206'),
('20200518182555'),
('20200518191004'),
('20200523184552'),
('20200526195031'),
('20200604102243'),
('20200604210255'),
('20200605030804');



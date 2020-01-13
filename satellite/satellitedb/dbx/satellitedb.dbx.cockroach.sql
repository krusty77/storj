-- AUTOGENERATED BY storj.io/dbx
-- DO NOT EDIT
CREATE TABLE accounting_rollups (
	id bigserial NOT NULL,
	node_id bytea NOT NULL,
	start_time timestamp with time zone NOT NULL,
	put_total bigint NOT NULL,
	get_total bigint NOT NULL,
	get_audit_total bigint NOT NULL,
	get_repair_total bigint NOT NULL,
	put_repair_total bigint NOT NULL,
	at_rest_total double precision NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE accounting_timestamps (
	name text NOT NULL,
	value timestamp with time zone NOT NULL,
	PRIMARY KEY ( name )
);
CREATE TABLE bucket_bandwidth_rollups (
	bucket_name bytea NOT NULL,
	project_id bytea NOT NULL,
	interval_start timestamp NOT NULL,
	interval_seconds integer NOT NULL,
	action integer NOT NULL,
	inline bigint NOT NULL,
	allocated bigint NOT NULL,
	settled bigint NOT NULL,
	PRIMARY KEY ( bucket_name, project_id, interval_start, action )
);
CREATE TABLE bucket_storage_tallies (
	bucket_name bytea NOT NULL,
	project_id bytea NOT NULL,
	interval_start timestamp NOT NULL,
	inline bigint NOT NULL,
	remote bigint NOT NULL,
	remote_segments_count integer NOT NULL,
	inline_segments_count integer NOT NULL,
	object_count integer NOT NULL,
	metadata_size bigint NOT NULL,
	PRIMARY KEY ( bucket_name, project_id, interval_start )
);
CREATE TABLE coinpayments_transactions (
	id text NOT NULL,
	user_id bytea NOT NULL,
	address text NOT NULL,
	amount bytea NOT NULL,
	received bytea NOT NULL,
	status integer NOT NULL,
	key text NOT NULL,
	timeout integer NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE coupons (
	id bytea NOT NULL,
	project_id bytea NOT NULL,
	user_id bytea NOT NULL,
	amount bigint NOT NULL,
	description text NOT NULL,
	type integer NOT NULL,
	status integer NOT NULL,
	duration bigint NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE coupon_usages (
	coupon_id bytea NOT NULL,
	amount bigint NOT NULL,
	status integer NOT NULL,
	period timestamp with time zone NOT NULL,
	PRIMARY KEY ( coupon_id, period )
);
CREATE TABLE graceful_exit_progress (
	node_id bytea NOT NULL,
	bytes_transferred bigint NOT NULL,
	pieces_transferred bigint NOT NULL,
	pieces_failed bigint NOT NULL,
	updated_at timestamp NOT NULL,
	PRIMARY KEY ( node_id )
);
CREATE TABLE graceful_exit_transfer_queue (
	node_id bytea NOT NULL,
	path bytea NOT NULL,
	piece_num integer NOT NULL,
	root_piece_id bytea,
	durability_ratio double precision NOT NULL,
	queued_at timestamp NOT NULL,
	requested_at timestamp,
	last_failed_at timestamp,
	last_failed_code integer,
	failed_count integer,
	finished_at timestamp,
	order_limit_send_count integer NOT NULL,
	PRIMARY KEY ( node_id, path, piece_num )
);
CREATE TABLE injuredsegments (
	path bytea NOT NULL,
	data bytea NOT NULL,
	attempted timestamp,
	PRIMARY KEY ( path )
);
CREATE TABLE irreparabledbs (
	segmentpath bytea NOT NULL,
	segmentdetail bytea NOT NULL,
	pieces_lost_count bigint NOT NULL,
	seg_damaged_unix_sec bigint NOT NULL,
	repair_attempt_count bigint NOT NULL,
	PRIMARY KEY ( segmentpath )
);
CREATE TABLE nodes (
	id bytea NOT NULL,
	address text NOT NULL,
	last_net text NOT NULL,
	protocol integer NOT NULL,
	type integer NOT NULL,
	email text NOT NULL,
	wallet text NOT NULL,
	free_bandwidth bigint NOT NULL,
	free_disk bigint NOT NULL,
	piece_count bigint NOT NULL,
	major bigint NOT NULL,
	minor bigint NOT NULL,
	patch bigint NOT NULL,
	hash text NOT NULL,
	timestamp timestamp with time zone NOT NULL,
	release boolean NOT NULL,
	latency_90 bigint NOT NULL,
	audit_success_count bigint NOT NULL,
	total_audit_count bigint NOT NULL,
	uptime_success_count bigint NOT NULL,
	total_uptime_count bigint NOT NULL,
	created_at timestamp with time zone NOT NULL,
	updated_at timestamp with time zone NOT NULL,
	last_contact_success timestamp with time zone NOT NULL,
	last_contact_failure timestamp with time zone NOT NULL,
	contained boolean NOT NULL,
	disqualified timestamp with time zone,
	audit_reputation_alpha double precision NOT NULL,
	audit_reputation_beta double precision NOT NULL,
	uptime_reputation_alpha double precision NOT NULL,
	uptime_reputation_beta double precision NOT NULL,
	exit_initiated_at timestamp,
	exit_loop_completed_at timestamp,
	exit_finished_at timestamp,
	exit_success boolean NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE nodes_offline_times (
	node_id bytea NOT NULL,
	tracked_at timestamp with time zone NOT NULL,
	seconds integer NOT NULL,
	PRIMARY KEY ( node_id, tracked_at )
);
CREATE TABLE offers (
	id serial NOT NULL,
	name text NOT NULL,
	description text NOT NULL,
	award_credit_in_cents integer NOT NULL,
	invitee_credit_in_cents integer NOT NULL,
	award_credit_duration_days integer,
	invitee_credit_duration_days integer,
	redeemable_cap integer,
	expires_at timestamp with time zone NOT NULL,
	created_at timestamp with time zone NOT NULL,
	status integer NOT NULL,
	type integer NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE peer_identities (
	node_id bytea NOT NULL,
	leaf_serial_number bytea NOT NULL,
	chain bytea NOT NULL,
	updated_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( node_id )
);
CREATE TABLE pending_audits (
	node_id bytea NOT NULL,
	piece_id bytea NOT NULL,
	stripe_index bigint NOT NULL,
	share_size bigint NOT NULL,
	expected_share_hash bytea NOT NULL,
	reverify_count bigint NOT NULL,
	path bytea NOT NULL,
	PRIMARY KEY ( node_id )
);
CREATE TABLE projects (
	id bytea NOT NULL,
	name text NOT NULL,
	description text NOT NULL,
	usage_limit bigint NOT NULL,
	partner_id bytea,
	owner_id bytea NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE registration_tokens (
	secret bytea NOT NULL,
	owner_id bytea,
	project_limit integer NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( secret ),
	UNIQUE ( owner_id )
);
CREATE TABLE reset_password_tokens (
	secret bytea NOT NULL,
	owner_id bytea NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( secret ),
	UNIQUE ( owner_id )
);
CREATE TABLE serial_numbers (
	id serial NOT NULL,
	serial_number bytea NOT NULL,
	bucket_id bytea NOT NULL,
	expires_at timestamp NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE storagenode_bandwidth_rollups (
	storagenode_id bytea NOT NULL,
	interval_start timestamp NOT NULL,
	interval_seconds integer NOT NULL,
	action integer NOT NULL,
	allocated bigint,
	settled bigint NOT NULL,
	PRIMARY KEY ( storagenode_id, interval_start, action )
);
CREATE TABLE storagenode_storage_tallies (
	id bigserial NOT NULL,
	node_id bytea NOT NULL,
	interval_end_time timestamp with time zone NOT NULL,
	data_total double precision NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE stripe_customers (
	user_id bytea NOT NULL,
	customer_id text NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( user_id ),
	UNIQUE ( customer_id )
);
CREATE TABLE stripecoinpayments_invoice_project_records (
	id bytea NOT NULL,
	project_id bytea NOT NULL,
	storage double precision NOT NULL,
	egress bigint NOT NULL,
	objects bigint NOT NULL,
	period_start timestamp with time zone NOT NULL,
	period_end timestamp with time zone NOT NULL,
	state integer NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id ),
	UNIQUE ( project_id, period_start, period_end )
);
CREATE TABLE stripecoinpayments_tx_conversion_rates (
	tx_id text NOT NULL,
	rate bytea NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( tx_id )
);
CREATE TABLE users (
	id bytea NOT NULL,
	email text NOT NULL,
	normalized_email text NOT NULL,
	full_name text NOT NULL,
	short_name text,
	password_hash bytea NOT NULL,
	status integer NOT NULL,
	partner_id bytea,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id )
);
CREATE TABLE value_attributions (
	project_id bytea NOT NULL,
	bucket_name bytea NOT NULL,
	partner_id bytea NOT NULL,
	last_updated timestamp NOT NULL,
	PRIMARY KEY ( project_id, bucket_name )
);
CREATE TABLE api_keys (
	id bytea NOT NULL,
	project_id bytea NOT NULL REFERENCES projects( id ) ON DELETE CASCADE,
	head bytea NOT NULL,
	name text NOT NULL,
	secret bytea NOT NULL,
	partner_id bytea,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id ),
	UNIQUE ( head ),
	UNIQUE ( name, project_id )
);
CREATE TABLE bucket_metainfos (
	id bytea NOT NULL,
	project_id bytea NOT NULL REFERENCES projects( id ),
	name bytea NOT NULL,
	partner_id bytea,
	path_cipher integer NOT NULL,
	created_at timestamp with time zone NOT NULL,
	default_segment_size integer NOT NULL,
	default_encryption_cipher_suite integer NOT NULL,
	default_encryption_block_size integer NOT NULL,
	default_redundancy_algorithm integer NOT NULL,
	default_redundancy_share_size integer NOT NULL,
	default_redundancy_required_shares integer NOT NULL,
	default_redundancy_repair_shares integer NOT NULL,
	default_redundancy_optimal_shares integer NOT NULL,
	default_redundancy_total_shares integer NOT NULL,
	PRIMARY KEY ( id ),
	UNIQUE ( name, project_id )
);
CREATE TABLE project_invoice_stamps (
	project_id bytea NOT NULL REFERENCES projects( id ) ON DELETE CASCADE,
	invoice_id bytea NOT NULL,
	start_date timestamp with time zone NOT NULL,
	end_date timestamp with time zone NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( project_id, start_date, end_date ),
	UNIQUE ( invoice_id )
);
CREATE TABLE project_members (
	member_id bytea NOT NULL REFERENCES users( id ) ON DELETE CASCADE,
	project_id bytea NOT NULL REFERENCES projects( id ) ON DELETE CASCADE,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( member_id, project_id )
);
CREATE TABLE stripecoinpayments_apply_balance_intents (
	tx_id text NOT NULL REFERENCES coinpayments_transactions( id ) ON DELETE CASCADE,
	state integer NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( tx_id )
);
CREATE TABLE used_serials (
	serial_number_id integer NOT NULL REFERENCES serial_numbers( id ) ON DELETE CASCADE,
	storage_node_id bytea NOT NULL,
	PRIMARY KEY ( serial_number_id, storage_node_id )
);
CREATE TABLE user_credits (
	id serial NOT NULL,
	user_id bytea NOT NULL REFERENCES users( id ) ON DELETE CASCADE,
	offer_id integer NOT NULL REFERENCES offers( id ),
	referred_by bytea REFERENCES users( id ) ON DELETE SET NULL,
	type text NOT NULL,
	credits_earned_in_cents integer NOT NULL,
	credits_used_in_cents integer NOT NULL,
	expires_at timestamp with time zone NOT NULL,
	created_at timestamp with time zone NOT NULL,
	PRIMARY KEY ( id ),
	UNIQUE ( id, offer_id )
);
CREATE INDEX bucket_name_project_id_interval_start_interval_seconds ON bucket_bandwidth_rollups ( bucket_name, project_id, interval_start, interval_seconds );
CREATE INDEX injuredsegments_attempted_index ON injuredsegments ( attempted );
CREATE INDEX node_last_ip ON nodes ( last_net );
CREATE INDEX nodes_offline_times_node_id_index ON nodes_offline_times ( node_id );
CREATE UNIQUE INDEX serial_number ON serial_numbers ( serial_number );
CREATE INDEX serial_numbers_expires_at_index ON serial_numbers ( expires_at );
CREATE INDEX storagenode_id_interval_start_interval_seconds ON storagenode_bandwidth_rollups ( storagenode_id, interval_start, interval_seconds );
CREATE UNIQUE INDEX credits_earned_user_id_offer_id ON user_credits ( id, offer_id );
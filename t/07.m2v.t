use Test::More tests => 23;
use FFmpeg;
use Data::Dumper;

my $fname = "eg/t1.m2v";

ok(my $ff = FFmpeg->new(input_file => $fname) , 'ff object created successfully');
ok($ff->isa('FFmpeg')                         , 'object correct type');
ok(my $sg = $ff->create_streamgroup           , 'streamgroup object created successfully');
ok($sg->isa('FFmpeg::StreamGroup')            , 'object correct type');

ok($sg->duration->isa('Time::Piece')          , 'object correct type');
is($sg->duration->hms, '00:00:00'             , 'streamgroup duration correct');
is(scalar($sg->streams), 1                    , 'stream count correct');
is(scalar(grep {$_->is_video} $sg->streams), 1, 'video stream count correct');
is(scalar(grep {$_->is_audio} $sg->streams), 0, 'audio stream count correct');

ok(!$sg->has_audio                            , 'audio detected ok');
ok($sg->has_video                             , 'video detected ok');

is($sg->album, ''                             , 'streamgroup album ok');
is($sg->author, ''                            , 'streamgroup author ok');
is($sg->bit_rate, 0                           , 'streamgroup bit_rate ok');
is($sg->comment, ''                           , 'streamgroup comment ok');
is($sg->copyright, ''                         , 'streamgroup copyright ok');
is($sg->data_offset, 0                        , 'streamgroup data_offset ok');
is($sg->file_size, 39869                      , 'streamgroup file_size ok');
is($sg->format->name, 'mpegvideo'             , 'streamgroup format ok');
is($sg->genre, ''                             , 'streamgroup genre ok');
is($sg->track, 0                              , 'streamgroup track ok');
is($sg->url, $fname                           , 'streamgroup url ok');
is($sg->year, 0                               , 'streamgroup year ok');

#warn Dumper($sg);

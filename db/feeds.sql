-- phpMyAdmin SQL Dump
-- version 2.8.2.4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Dec 07, 2006 at 09:25 PM
-- Server version: 5.0.24
-- PHP Version: 5.1.6
-- 
-- Database: `bottomfeeder_dev`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `feeds`
-- 

CREATE TABLE `feeds` (
  `id` int(11) NOT NULL auto_increment,
  `parser` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `last_read_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=517 DEFAULT CHARSET=latin1 AUTO_INCREMENT=517 ;

-- 
-- Dumping data for table `feeds`
-- 

INSERT INTO `feeds` (`id`, `parser`, `title`, `url`, `created_at`, `last_read_at`) VALUES (271, '', 'Mission Data Blog', 'http://blogs.missiondata.com/feed/', '2006-11-28 18:19:56', NULL),
(272, '', 'Err the Blog', 'http://feeds.feedburner.com/errtheblog', '2006-11-28 18:28:33', NULL),
(273, '', 'po-ru.com', 'http://po-ru.com/', '2006-11-28 18:29:35', NULL),
(274, '', 'deferred until inspiration hits', 'http://feeds.feedburner.com/DeferredUntilInspirationHits', '2006-11-28 18:30:49', NULL),
(275, '', 'Floehopper', 'http://blog.floehopper.org/xml/atom/feed.xml', '2006-11-28 18:31:23', NULL),
(276, '', 'Ben Griffiths'' weblog', 'http://www.reevoo.com/blogs/bengriffiths/feed/', '2006-11-28 18:32:14', NULL),
(277, '', 'Jay Fields Thoughts', 'http://jayfields.blogspot.com/atom.xml', '2006-11-28 18:35:45', NULL),
(279, '', 'Elizabeth''s Blog', 'http://naramore.net/blog/wp-rss2.php', '2006-11-28 18:43:24', NULL),
(281, '', 'Gluttonous', 'http://feeds.feedburner.com/Gluttonous', '2006-11-28 18:48:32', NULL),
(282, '', 'LRUG | London Ruby User Group', 'http://www.lrug.org/', '2006-11-28 18:57:10', NULL),
(283, '', 'Arno''s Blog', 'http://arno.org/blog/atom.xml', '2006-11-28 22:41:40', NULL),
(284, '', 'Martin Fowler&apos;s Bliki', 'http://www.martinfowler.com/bliki/bliki.rss', '2006-11-28 22:48:25', NULL),
(289, '', 'True Hacker!', 'http://truehacker.blogspot.com/feeds/posts/default', '2006-11-29 14:27:00', NULL),
(290, '', 'Stickis: social + web + overlay', 'http://blog.stickis.com/feed/', '2006-11-29 17:34:41', NULL),
(291, '', 'Red Squirrel Reflections', 'http://redsquirrel.com/cgi-bin/dave', '2006-11-29 18:51:56', NULL),
(292, '', 'codewalkers.com - main page - PHP Help', 'http://codewalkers.com/index.php', '2006-11-29 18:57:08', NULL),
(293, '', 'Codewalkers News', 'http://codewalkers.com/news.rdf', '2006-11-29 19:02:08', NULL),
(294, '', 'Matt McCray', 'http://feeds.feedburner.com/mattmccray', '2006-11-29 19:06:52', NULL),
(295, '', 'The NeoSmart Files', 'http://neosmart.net/blog/feed/', '2006-11-29 19:09:58', NULL),
(297, '', 'Zillow Blog', 'http://zillowblog.typepad.com/zillow_blog/atom.xml', '2006-11-29 20:30:10', NULL),
(298, '', 'How to Change the World', 'http://blog.guykawasaki.com/atom.xml', '2006-11-29 20:44:19', NULL),
(299, '', 'Article RSS Feed', 'http://feeds.feedburner.com/ElevatedRailsRssFeed', '2006-11-30 00:28:09', NULL),
(300, '', 'Fun With Radiant', 'http://feeds.feedburner.com/FunWithRadiant', '2006-11-30 00:30:48', NULL),
(301, '', 'James Governor&apos;s MonkChips', 'http://www.redmonk.com/jgovernor/index.rdf', '2006-12-03 14:54:20', NULL),
(302, '', 'scottraymondnet 2006 - Home', 'http://scottraymond.net/feed/atom.xml', '2006-12-03 16:59:14', NULL),
(303, '', 'Painfully Obvious', 'http://www.andrewdupont.net/feed/', '2006-12-03 17:04:45', NULL),
(304, '', 'Future Feeder', 'http://feeds.feedburner.com/FutureFeeder', '2006-12-03 17:15:28', NULL),
(305, '', 'Life 2.0', 'http://feeds.feedburner.com/Life2point0', '2006-12-03 19:39:55', NULL),
(306, '', '~:caboose', 'http://blog.caboo.se/xml/atom/feed.xml', '2006-12-04 00:07:15', NULL),
(308, '', 'ongoing', 'http://www.tbray.org/ongoing/', '2006-12-04 09:18:51', NULL),
(309, '', 'Wheaties for Your Wallet', 'http://blog.wesabe.com/index.php/feed/', '2006-12-04 09:20:34', NULL),
(310, '', 'John Battelle''s Searchblog', 'http://battellemedia.com/index.xml', '2006-12-04 09:42:03', NULL),
(311, '', 'Read/WriteWeb', 'http://www.readwriteweb.com/rss.xml', '2006-12-04 09:43:33', NULL),
(312, '', 'Geeking with Greg', 'http://glinden.blogspot.com/atom.xml', '2006-12-04 09:45:08', NULL),
(313, '', 'Official Google Blog', 'http://googleblog.blogspot.com/atom.xml', '2006-12-04 10:08:49', NULL),
(319, '', 'Escape from Cubicle Nation', 'http://www.escapefromcubiclenation.com/get_a_life_blog/atom.xml', '2006-12-04 13:33:00', NULL),
(320, '', 'Phil Windley&apos;s Technometria', 'http://www.windley.com/rss.xml', '2006-12-04 13:34:50', NULL),
(321, '', 'kottke.org', 'http://feeds.kottke.org/main', '2006-12-04 13:38:36', NULL),
(322, '', 'Steve Eichert', 'http://steve.emxsoftware.com/rss.aspx', '2006-12-05 18:58:45', NULL),
(323, '', 'Pete Lacey''s Weblog', 'http://wanderingbarque.com/nonintersecting/feed/atom/', '2006-12-06 11:43:29', NULL),
(324, '', 'What Not How', 'http://duncan-cragg.org/blog/atom/', '2006-12-06 12:41:56', NULL),
(326, '', 'The Cafes', 'http://cafe.elharo.com/feed/?', '2006-12-06 23:00:52', NULL),
(327, '', 'Service Architecture - SOA', 'http://service-architecture.blogspot.com/', '2006-12-06 23:03:49', NULL),
(329, '', 'Web Worker Daily', 'http://feeds.feedburner.com/Webworkerdaily', '2006-12-06 23:12:52', NULL),
(330, '', 'del.icio.us/popular/rails', 'http://del.icio.us/rss/popular/rails', '2006-12-06 23:19:24', NULL),
(331, '', '0xDECAFBAD', 'http://decafbad.com/blog/feed/rdf', '2006-12-07 17:28:30', NULL),
(332, '', 'Adam Bosworth''s Weblog', 'http://feeds.feedburner.com/adambosworth/thoughts', '2006-12-07 17:28:30', NULL),
(333, '', 'Aimless Words - GMail News and Software', 'http://www.aimlesswords.com/gmail.xml', '2006-12-07 17:28:30', NULL),
(334, '', 'AkuAku', 'http://www.akuaku.org/index.rdf', '2006-12-07 17:28:30', NULL),
(335, '', 'backstage.bbc.co.uk :: Backstage.bbc.co.uk: Backstage Blog', 'http://backstage.bbc.co.uk/news/index.xml', '2006-12-07 17:28:30', NULL),
(336, '', 'Bare Naked App', 'http://feeds.feedburner.com/barenakedapp', '2006-12-07 17:28:30', NULL),
(337, '', 'Basement.org', 'http://feeds.feedburner.com/Basementorg', '2006-12-07 17:28:30', NULL),
(338, '', 'Berkun blog', 'http://www.scottberkun.com/blog/?feed=rss2', '2006-12-07 17:28:30', NULL),
(339, '', 'BeyondVC', 'http://feeds.feedburner.com/beyondvc/ThoJ', '2006-12-07 17:28:30', NULL),
(340, '', 'The Big Act by Sproutit.com', 'http://feeds.feedburner.com/bigact', '2006-12-07 17:28:30', NULL),
(341, '', 'Bloglines | News', 'http://www.bloglines.com/rss/about/news', '2006-12-07 17:28:31', NULL),
(342, '', 'Chase Jarvis Blog', 'http://feeds.feedburner.com/ChaseJarvis', '2006-12-07 17:28:31', NULL),
(343, '', 'The Chief Happiness Officer', 'http://positivesharing.com/?feed=rss2', '2006-12-07 17:28:31', NULL),
(344, '', 'Creating Passionate Users', 'http://headrush.typepad.com/creating_passionate_users/index.rdf', '2006-12-07 17:28:31', NULL),
(345, '', 'CrunchBoard', 'http://www.crunchboard.com/feed/businessexec', '2006-12-07 17:28:31', NULL),
(346, '', 'Dapper', 'http://dapper.wordpress.com/feed/', '2006-12-07 17:28:31', NULL),
(347, '', 'del.icio.us/tag/rubyonrails', 'http://del.icio.us/rss/tag/rubyonrails', '2006-12-07 17:28:31', NULL),
(348, '', 'Derek Sivers, O''Reilly Network', 'http://www.oreillynet.com/feeds/author/?x-au=1841', '2006-12-07 17:28:31', NULL),
(349, '', 'Design Fu', 'http://www.gnome.org/~seth/blog//?flav=rss', '2006-12-07 17:28:31', NULL),
(350, '', 'Dilbert', 'http://www.caesar.nl/CaesarRSS/DilbertRSS.aspx', '2006-12-07 17:28:31', NULL),
(351, '', 'doron''s blaahg', 'http://weblogs.mozillazine.org/doron/index.rdf', '2006-12-07 17:28:31', NULL),
(352, '', 'Feedhacks', 'http://www.feedhacks.com/blog/wp-rss2.php', '2006-12-07 17:28:32', NULL),
(353, '', 'FlickrBits', 'http://www.flickrbits.com/feed', '2006-12-07 17:28:32', NULL),
(354, '', 'Flickrzen', 'http://feeds.feedburner.com/Flickrzen', '2006-12-07 17:28:32', NULL),
(355, '', 'Functioning Form: Interface Design', 'http://feeds.feedburner.com/FunctioningForm', '2006-12-07 17:28:32', NULL),
(356, '', 'FuzzyBlog', 'http://fuzzyblog.com/feed/', '2006-12-07 17:28:32', NULL),
(357, '', 'gapingvoid: "cartoons drawn on the back of business cards"', 'http://www.gapingvoid.com/atom.xml', '2006-12-07 17:28:32', NULL),
(358, '', 'GOOD Magazine', 'http://www.goodmagazine.com/fieldwork/rss', '2006-12-07 17:28:32', NULL),
(359, '', 'hackdiary', 'http://www.hackdiary.com/index.rdf', '2006-12-07 17:28:32', NULL),
(360, '', 'How to Change the World', 'http://blog.guykawasaki.com/rss.xml', '2006-12-07 17:28:32', NULL),
(361, '', 'http://blog.hasmanythrough.com/', 'http://blog.hasmanythrough.com/', '2006-12-07 17:28:32', NULL),
(362, '', 'http://blogs.pragprog.com/cgi-bin/pragdave.cgi', 'http://blogs.pragprog.com/cgi-bin/pragdave.cgi', '2006-12-07 17:28:32', NULL),
(363, '', 'I, Cringely @ PBS.org', 'http://cgi.pbs.org/cgi-registry/cringely/cringelyrdf.pl', '2006-12-07 17:28:32', NULL),
(364, '', 'Islay - ×‘×œ×•×’ ×•×•×™×¡×§', 'http://israblog.nana.co.il/blog_rss.asp?blog=10595', '2006-12-07 17:28:32', NULL),
(365, '', 'IsraelWebTour', 'http://feeds.feedburner.com/typepad/israelwebtour/blog', '2006-12-07 17:28:33', NULL),
(366, '', 'Jeffrey Veen', 'http://veen.com/jeff/rss.xml', '2006-12-07 17:28:33', NULL),
(367, '', 'Jeremy Zawodny''s blog', 'http://jeremy.zawodny.com/blog/rss2.xml', '2006-12-07 17:28:33', NULL),
(368, '', 'jobs.joelonsoftware.com', 'http://jobs.joelonsoftware.com/default.asp?pg=pgFeed&feed=644012', '2006-12-07 17:28:33', NULL),
(369, '', 'Joel on Software', 'http://www.joelonsoftware.com/rss.xml', '2006-12-07 17:28:33', NULL),
(370, '', 'JotBlog', 'http://blog.jot.com/feed/rss2/', '2006-12-07 17:28:33', NULL),
(371, '', 'JustinFrench.com - notebook', 'http://justinfrench.com/?rss=1&section=notebook', '2006-12-07 17:28:33', NULL),
(372, '', 'Kinetic', 'http://korrespondence.blogspot.com/atom.xml', '2006-12-07 17:28:33', NULL),
(373, '', 'Labnotes', 'http://blog.labnotes.org/feed', '2006-12-07 17:28:33', NULL),
(374, '', 'The Laws of Simplicity', 'http://lawsofsimplicity.com/?feed=rss2', '2006-12-07 17:28:33', NULL),
(375, '', 'Lifehacker', 'http://feeds.gawker.com/lifehacker/full', '2006-12-07 17:28:33', NULL),
(376, '', 'The Long Tail', 'http://www.longtail.com/the_long_tail/rss.xml', '2006-12-07 17:28:33', NULL),
(377, '', 'Magpie Blog', 'http://magpie.laughingmeme.org/blog/wp-rss2.php', '2006-12-07 17:28:33', NULL),
(378, '', 'Mike Rowehl', 'http://www.bitsplitter.net/blog/wp-rss2.php', '2006-12-07 17:28:33', NULL),
(379, '', 'MikeNaberezny.com', 'http://www.mikenaberezny.com/feed/', '2006-12-07 17:28:33', NULL),
(380, '', 'MobileCrunch', 'http://feeds.feedburner.com/Mobilecrunch', '2006-12-07 17:28:34', NULL),
(381, '', 'monkey methods', 'http://blog.monkeymethods.org/atom.xml', '2006-12-07 17:28:34', NULL),
(382, '', 'nat friedman', 'http://www.nat.org/rss.xml', '2006-12-07 17:28:34', NULL),
(383, '', 'The New York Web 2.0 for Grass Root Causes Meetup Group: What''s ', 'http://www.meetup.com/rss/g/web/27/new/', '2006-12-07 17:28:34', NULL),
(384, '', 'Nivi', 'http://feeds.feedburner.com/nivi', '2006-12-07 17:28:34', NULL),
(385, '', 'Noam Wasserman''s "Founder Frustrations" blog', 'http://founderresearch.blogspot.com/atom.xml', '2006-12-07 17:28:34', NULL),
(386, '', 'Nuby on Rails', 'http://nubyonrails.com/xml/rss', '2006-12-07 17:28:34', NULL),
(387, '', 'nycruby', 'http://nycruby.org/wiki/feed.rss', '2006-12-07 17:28:34', NULL),
(388, '', 'O''Reilly Radar', 'http://radar.oreilly.com/atom.xml', '2006-12-07 17:28:34', NULL),
(389, '', 'On the Face', 'http://ontheface.blogware.com/blog/index.xml', '2006-12-07 17:28:35', NULL),
(390, '', 'On the FACE .....', 'http://ontheface.blogspot.com/atom.xml', '2006-12-07 17:28:35', NULL),
(391, '', 'OpenEverything.org', 'http://openeverything.org/feed', '2006-12-07 17:28:35', NULL),
(392, '', 'Paul Graham: Unofficial RSS Feed', 'http://joegrossberg.com/paulgraham.rss', '2006-12-07 17:28:35', NULL),
(393, '', 'Photon Detector', 'http://photondetector.com/blog/?feed=rss2', '2006-12-07 17:28:35', NULL),
(394, '', 'Pink: General Blog', 'http://feeds.feedburner.com/PinkGeneralBlog', '2006-12-07 17:28:35', NULL),
(395, '', 'plaintext', 'http://niryariv.wordpress.com/feed', '2006-12-07 17:28:35', NULL),
(396, '', 'Planet FOSS-IL', 'http://foss-il.ev-en.org/rss20.xml', '2006-12-07 17:28:35', NULL),
(397, '', 'Planet PHP', 'http://www.planet-php.org/rss/', '2006-12-07 17:28:35', NULL),
(398, '', 'Planet RubyOnRails', 'http://feeds.feedburner.com/planetrubyonrails', '2006-12-07 17:28:35', NULL),
(399, '', 'plasticbag.org', 'http://www.plasticbag.org/index.rdf', '2006-12-07 17:28:35', NULL),
(400, '', 'PopularMechanics.com - Blogs: Science News', 'http://feeds.popularmechanics.com/pm/blogs/science_news', '2006-12-07 17:28:35', NULL),
(401, '', 'Programming Jobs on AgileWebDevelopment.com', 'http://agilewebdevelopment.jobcoin.com/jobs/category_rss/599-programming', '2006-12-07 17:28:35', NULL),
(402, '', 'Publishing 2.0', 'http://feeds.feedburner.com/Publishing20', '2006-12-07 17:28:35', NULL),
(403, '', 'Puzzlepieces', 'http://www.faganfinder.com/wp/feed/atom/', '2006-12-07 17:28:35', NULL),
(404, '', 'Raganwald', 'http://weblog.raganwald.com/atom.xml', '2006-12-07 17:28:35', NULL),
(405, '', 'Random Memoirs', 'http://www.iosart.com/blog/feed/', '2006-12-07 17:28:36', NULL),
(406, '', 'Recent Programming Gigs', 'http://gigs.37signals.com/categories/12/gigs.rss', '2006-12-07 17:28:36', NULL),
(407, '', 'Recent Programming Jobs', 'http://jobs.37signals.com/categories/2/jobs;rss', '2006-12-07 17:28:36', NULL),
(408, '', 'Sam Ruby', 'http://intertwingly.net/blog/index.atom', '2006-12-07 17:28:36', NULL),
(409, '', 'SF Tech Sessions', 'http://sftechsessions.com/feed/', '2006-12-07 17:28:36', NULL),
(410, '', 'ShaunInman.com // Complete plus These Links? Again?', 'http://www.shauninman.com/post/feeds/plus', '2006-12-07 17:28:36', NULL),
(411, '', 'shimonolog: Shimon Rura''s Blog', 'http://frassle.net/Directory/rss?id=1&cat=0', '2006-12-07 17:28:36', NULL),
(412, '', 'Shnoo.gr', 'http://feeds.feedburner.com/Shnoogr', '2006-12-07 17:28:37', NULL),
(413, '', 'Signal vs. Noise', 'http://feeds.feedburner.com/37signals/beMH', '2006-12-07 17:28:37', NULL),
(414, '', 'SiliconBeat', 'http://www.siliconbeat.com/index.rdf', '2006-12-07 17:28:37', NULL),
(415, '', 'Simon Willison''s Weblog', 'http://simon.incutio.com/syndicate/rss1.0', '2006-12-07 17:28:37', NULL),
(416, '', 'Smallthought', 'http://dabbledb.com/blog/?feed=rss2', '2006-12-07 17:28:37', NULL),
(417, '', 'Spark This', 'http://feeds.feedburner.com/SparkThis', '2006-12-07 17:28:37', NULL),
(418, '', 'Stake Ventures', 'http://feeds.feedburner.com/StakeVentures', '2006-12-07 17:28:37', NULL),
(419, '', 'Steve Pavlina''s Personal Development Blog', 'http://www.stevepavlina.com/blog/feed/', '2006-12-07 17:28:37', NULL),
(420, '', 'StevenLevy.com', 'http://www.stevenlevy.com/index.php/feed/', '2006-12-07 17:28:37', NULL),
(421, '', 'TechCrunch', 'http://feeds.feedburner.com/Techcrunch', '2006-12-07 17:28:37', NULL),
(422, '', 'Technology Jobs Weblog', 'http://feeds.feedburner.com/TechnologyJobsWeblog', '2006-12-07 17:28:37', NULL),
(423, '', 'the.co.ils', 'http://feeds.feedburner.com/Thecoils', '2006-12-07 17:28:37', NULL),
(424, '', 'Tim O''Reilly''s Archive', 'http://www.oreillynet.com/rss/render/341.rss', '2006-12-07 17:28:37', NULL),
(425, '', 'To-Done', 'http://feeds.feedburner.com/To-done', '2006-12-07 17:28:37', NULL),
(426, '', 'Tuzig', 'http://blog.tuzig.com/feed/', '2006-12-07 17:28:37', NULL),
(427, '', 'VentureBeat: Design Jobs', 'http://jobs.venturebeat.com/designjobs/feeds/rss20', '2006-12-07 17:28:37', NULL),
(428, '', 'Vitamin', 'http://feeds.feedburner.com/vitaminmasterfeed', '2006-12-07 17:28:38', NULL),
(429, '', 'wannabe3.1: Category rssfwd', 'http://blog.yanime.org/xml/rss/rssfwd/feed.xml', '2006-12-07 17:28:38', NULL),
(430, '', 'Web 2.0 Thoughts', 'http://feeds.feedburner.com/Web20Thoughts', '2006-12-07 17:28:38', NULL),
(431, '', 'What''s That Noise?! [Ian Kallen''s Weblog]', 'http://www.arachna.com/roller/rss/spidaman?catname=/LAMP', '2006-12-07 17:28:38', NULL),
(432, '', 'Wingedpig.com - Mark Fletcher''s Blog', 'http://www.wingedpig.com/index.rdf', '2006-12-07 17:28:38', NULL),
(433, '', 'WorldChanging: Tools, Models and Ideas for Building a Bright Gre', 'http://www.worldchanging.com/index.xml', '2006-12-07 17:28:38', NULL),
(434, '', 'xigi.net', 'http://www.xigi.net/?feed=rss2', '2006-12-07 17:28:38', NULL),
(435, '', 'Yedda. The Blog.', 'http://blog.yedda.org/feed/', '2006-12-07 17:28:39', NULL),
(436, '', 'Zend Technologies', 'http://blogs.zend.com/feed/', '2006-12-07 17:28:39', NULL),
(437, '', '×—×“×©×•×ª ×ž×¤×œ×’×ª ×”×™×¨×•×§×™×', 'http://www.green-party.co.il/news/?feed=rss2', '2006-12-07 17:28:39', NULL),
(438, '', '×œ×©×‘×ª, ×œ×©×ª×•×ª ×•×œ×©×›×•×—', 'http://gisser.wordpress.com/feed/', '2006-12-07 17:28:39', NULL),
(439, '', '×¨×“×™×§×œ ×ž×§×œ×“', 'http://www.notes.co.il/rss.asp?b=48', '2006-12-07 17:28:39', NULL),
(443, '', '(24)slash7', 'http://slash7.com/xml/rss20/feed.xml', '2006-12-07 17:35:18', NULL),
(444, '', '*scottstuff*', 'http://scottstuff.net/blog/xml/rss/feed.xml', '2006-12-07 17:35:18', NULL),
(445, '', '@Lathi.net', 'http://blog.lathi.net/xml/rss20/feed.xml', '2006-12-07 17:35:18', NULL),
(446, '', 'Anarchogeek', 'http://www.anarchogeek.com/xml/rss', '2006-12-07 17:35:18', NULL),
(447, '', 'Approaching Normal', 'http://feeds.feedburner.com/ApproachingNormal', '2006-12-07 17:35:18', NULL),
(448, '', 'BenCurtis.com', 'http://www.bencurtis.com/feed/atom/', '2006-12-07 17:35:18', NULL),
(449, '', 'bleything.blog(:stuff)', 'http://feeds.feedburner.com/bleything/blog', '2006-12-07 17:35:18', NULL),
(450, '', 'blog.talbott.ws', 'http://blog.talbott.ws/xml/rss20/feed.xml', '2006-12-07 17:35:19', NULL),
(451, '', 'BlogFish', 'http://blog.innerewut.de/xml/rss/feed.xml', '2006-12-07 17:35:19', NULL),
(452, '', 'Busy As Hell', 'http://feeds.feedburner.com/BusyAsHell', '2006-12-07 17:35:19', NULL),
(453, '', 'but she''s a girl...', 'http://www.rousette.org.uk/blog/feed/rss2/', '2006-12-07 17:35:19', NULL),
(454, '', 'ChadFowler.com', 'http://feeds.feedburner.com/Chadfowlercom', '2006-12-07 17:35:19', NULL),
(455, '', 'codefluency', 'http://codefluency.com/xml/atom/feed.xml', '2006-12-07 17:35:19', NULL),
(456, '', 'conaltradh', 'http://blog.lavalamp.ca/xml/rss20/feed.xml', '2006-12-07 17:35:19', NULL),
(457, '', 'convergent arts', 'http://convergentarts.com/xml/rss/feed.xml', '2006-12-07 17:35:19', NULL),
(458, '', 'Curt''s Comments', 'http://feeds.feedburner.com/curthibbs', '2006-12-07 17:35:19', NULL),
(459, '', 'David''s Blog of DOOM', 'http://david.planetargon.us/xml/rss20/feed.xml', '2006-12-07 17:35:19', NULL),
(460, '', 'def euler(x); cos(x) + i*sin(x); end', 'http://feeds.feedburner.com/defeulerxcosxisinxend', '2006-12-07 17:35:20', NULL),
(461, '', 'EncyteMedia', 'http://feeds.feedburner.com/encytemedia', '2006-12-07 17:35:20', NULL),
(462, '', 'futuretrack5', 'http://feeds.feedburner.com/Futuretrack5', '2006-12-07 17:35:20', NULL),
(463, '', 'Gluttonous', 'http://glu.ttono.us/xml/rss20/feed.xml', '2006-12-07 17:35:20', NULL),
(464, '', 'has_many :through', 'http://blog.hasmanythrough.com/xml/atom10/feed.xml', '2006-12-07 17:35:20', NULL),
(465, '', 'HyperionReactor - Ruby On Rails', 'http://www.hyperionreactor.net/taxonomy/term/12/0/feed', '2006-12-07 17:35:20', NULL),
(466, '', 'I am rice', 'http://feeds.feedburner.com/mongoo/CTIN', '2006-12-07 17:35:20', NULL),
(467, '', 'iBrasten', 'http://ibrasten.com/xml/rss/feed.xml', '2006-12-07 17:35:20', NULL),
(468, '', 'interblah.net - Home', 'http://interblah.net/feed/atom.xml', '2006-12-07 17:35:20', NULL),
(469, '', 'Jason Watkins', 'http://blog.jasonwatkins.net/xml/rss20/feed.xml', '2006-12-07 17:35:20', NULL),
(470, '', 'Jason Wong', 'http://www.jasonwong.org/xml/rss20/feed.xml', '2006-12-07 17:35:20', NULL),
(471, '', 'jlaine.net', 'http://feeds.feedburner.com/jlainenet', '2006-12-07 17:35:20', NULL),
(472, '', 'jutopia', 'http://feeds.feedburner.com/jutopia', '2006-12-07 17:35:20', NULL),
(473, '', 'jvoorhis', 'http://feeds.feedburner.com/jvoorhis', '2006-12-07 17:35:20', NULL),
(474, '', 'Late to the Party', 'http://cwilliams.textdriven.com/xml/rss/feed.xml', '2006-12-07 17:35:20', NULL),
(475, '', 'Loud Thinking', 'http://feeds.feedburner.com/LoudThinking', '2006-12-07 17:35:20', NULL),
(476, '', 'Luke Redpath', 'http://www.lukeredpath.co.uk/index.php/feed/', '2006-12-07 17:35:20', NULL),
(477, '', 'mir.aculo.us', 'http://mir.aculo.us/rss/master', '2006-12-07 17:35:21', NULL),
(478, '', 'monkey in the middle', 'http://samuelk.info/xml/atom10/feed.xml', '2006-12-07 17:35:21', NULL),
(479, '', 'MyOwnDB Blog', 'http://www.myowndb.com/blog/?feed=rss2', '2006-12-07 17:35:21', NULL),
(480, '', 'Nimble Code', 'http://www.nimblecode.com/xml/rss20/feed.xml', '2006-12-07 17:35:21', NULL),
(481, '', 'Notes from a messy desk', 'http://feeds.feedburner.com/wossname', '2006-12-07 17:35:21', NULL),
(482, '', 'Nuby on Rails', 'http://nubyonrails.topfunky.com/xml/rss/feed.xml', '2006-12-07 17:35:21', NULL),
(483, '', 'oobablog: Blog of Paul Ingles', 'http://feeds.feedburner.com/oobaloo', '2006-12-07 17:35:21', NULL),
(484, '', 'overstimulate', 'http://overstimulate.com/xml/rss/feed.xml', '2006-12-07 17:35:21', NULL),
(485, '', 'pdx.rb', 'http://blog.pdxruby.org/xml/rss20/feed.xml', '2006-12-07 17:35:22', NULL),
(486, '', 'PJ Hyett', 'http://pjhyett.com/xml/rss/feed.xml', '2006-12-07 17:35:22', NULL),
(487, '', 'PluginAWeek', 'http://www.pluginaweek.org/feed/atom', '2006-12-07 17:35:22', NULL),
(488, '', 'Ponderings...: Category Ruby On Rails', 'http://www.eric-stewart.com/blog/xml/rss/category/rubyonrails/feed.xml', '2006-12-07 17:35:22', NULL),
(489, '', 'poocs.net', 'http://feeds.poocs.net/poocsnet', '2006-12-07 17:35:22', NULL),
(490, '', 'Projectionist', 'http://feeds.feedburner.com/projectionist', '2006-12-07 17:35:22', NULL),
(491, '', 'Rails Tips', 'http://feeds.feedburner.com/railstips', '2006-12-07 17:35:22', NULL),
(492, '', 'Railsdevelopment', 'http://feeds.feedburner.com/Railsdevelopment', '2006-12-07 17:35:22', NULL),
(493, '', 'Relevance', 'http://www.relevancellc.com/blogs/wp-rss2.php', '2006-12-07 17:35:22', NULL),
(494, '', 'Richard Livsey @ Livsey.org', 'http://livsey.org/feed/atom/', '2006-12-07 17:35:22', NULL),
(495, '', 'Riding Rails', 'http://weblog.rubyonrails.com/xml/rss20/feed.xml', '2006-12-07 17:35:22', NULL),
(496, '', 'Robby on Rails', 'http://www.robbyonrails.com/xml/rss/feed.xml', '2006-12-07 17:35:22', NULL),
(497, '', 'Ruby on Rails Podcast', 'http://podcast.rubyonrails.com/podcast.xml', '2006-12-07 17:35:22', NULL),
(498, '', 'Running with Rails !', 'http://typo.in/xml/rss/feed.xml', '2006-12-07 17:35:22', NULL),
(499, '', 'Ryan''s Scraps', 'http://feeds.feedburner.com/RyansScraps', '2006-12-07 17:35:22', NULL),
(500, '', 'Scott Raymond', 'http://scottraymond.net/xml/atom/feed.xml', '2006-12-07 17:35:23', NULL),
(501, '', 'Shugo''s Blog', 'http://blog.shugo.net/xml/rss/feed.xml', '2006-12-07 17:35:23', NULL),
(502, '', 'Sporkmonger', 'http://sporkmonger.com/xml/atom10/feed.xml', '2006-12-07 17:35:23', NULL),
(503, '', 'The Exciter', 'http://theexciter.com/feed/', '2006-12-07 17:35:23', NULL),
(504, '', 'the { buckblogs :here }', 'http://jamis.jamisbuck.org/xml/rss20/feed.xml', '2006-12-07 17:35:23', NULL),
(505, '', 'TinyScience Blog', 'http://tinyscience.com/blog/xml-rss2.php', '2006-12-07 17:35:23', NULL),
(506, '', 'too-biased - home', 'http://feeds.feedburner.com/too-biased/xml', '2006-12-07 17:35:23', NULL),
(507, '', 'tourb.us blog', 'http://feeds.feedburner.com/TourbusRubyRailsBlog', '2006-12-07 17:35:23', NULL),
(508, '', 'TupleShop', 'http://blog.tupleshop.com/feed/feed.xml', '2006-12-07 17:35:23', NULL),
(509, '', 'Typo Theme Contest', 'http://typogarden.com/xml/rss/feed.xml', '2006-12-07 17:35:23', NULL),
(510, '', 'Waste of Time', 'http://kasparov.skife.org/blog/index.rss', '2006-12-07 17:35:23', NULL),
(511, '', 'When in Doubt', 'http://journal.schubert.cx/xml/rss20/feed.xml', '2006-12-07 17:35:23', NULL),
(512, '', 'xml-blog', 'http://feeds.feedburner.com/Xml-blog', '2006-12-07 17:35:24', NULL),
(514, '', 'Technoblog', 'http://feeds.feedburner.com/rufytech', '2006-12-07 17:42:22', '2006-12-07 21:24:09'),
(515, '', 'Phoenix isn''t just a town in Arizona', 'http://blog.fallingsnow.net/feed/', '2006-12-07 20:03:56', NULL),
(516, '', 'On Ruby', 'http://on-ruby.blogspot.com/atom.xml', '2006-12-07 20:06:37', '2006-12-07 21:22:51');

-- --------------------------------------------------------

-- 
-- Table structure for table `items`
-- 

CREATE TABLE `items` (
  `id` int(11) NOT NULL auto_increment,
  `feed_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=72367 DEFAULT CHARSET=latin1 AUTO_INCREMENT=72367 ;

-- 
-- Dumping data for table `items`
-- 


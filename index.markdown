---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
---

<!-- ## このサイトについて -->


<div class="site-container">

<section class="hero">
	<div class="hero-inner">
		<img class="avatar" src="/img/avatar.jpg" alt="avatar" />
		<div class="intro">
			<h1>はじめまして — I'm u1e2k</h1>
			<p class="tagline">Web 開発 / デザイン / 小さな実験を楽しむ人</p>
			<p>このサイトでは、私のプロジェクト・考え・制作物をまとめています。ポートフォリオやブログのエントリを順次追加しています。</p>
			<p>
				<a class="btn" href="https://github.com/u1e2k?tab=repositories">プロジェクトを見る</a>
				<a class="btn btn-outline" href="mailto:u1e2k@proton.me">連絡する</a>
			</p>
		</div>
	</div>
</section>

<section id="projects" class="projects">
	<h2>Selected Projects</h2>
	<div class="projects-grid">
		<article class="project-card">
			<h3>Welcome to Jekyll</h3>
			<p>このサイトのベースとなる Jekyll のセットアップ例です。サンプル記事を参考にして下さい。</p>
			<a href="/jekyll/update/2025/10/31/welcome-to-jekyll.html">記事を読む →</a>
		</article>

		<article class="project-card">
			<h3>Project B</h3>
			<p>ここにはその他のプロジェクトやワークサンプルの概要を掲載します。</p>
			<a href="#">詳細を見る →</a>
		</article>

		<article class="project-card">
			<h3>Project C</h3>
			<p>デザイン、実装、デプロイまでの流れを短く紹介します。</p>
			<a href="#">詳細を見る →</a>
		</article>
	</div>
</section>

{% if site.posts and site.posts.size > 0 %}
<section class="recent-posts">
	<h2>Latest Posts</h2>
	<div class="projects-grid">
		{% for post in site.posts limit:3 %}
		<article class="project-card post-card">
			<h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
			<time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>
			<p>{{ post.excerpt | strip_html | truncate: 140 }}</p>
		</article>
		{% endfor %}
	</div>
</section>
{% endif %}

<section id="contact" class="contact">
	<h2>Contact</h2>
	<p>ご連絡はメールまたは GitHub の Issue/PR でお願いします。</p>
	<p class="contact-list">
		<strong>Email:</strong> <a href="mailto:u1e2k@proton.me">u1e2k@proton.me</a><br>
		<strong>GitHub:</strong> <a href="https://github.com/u1e2k">@u1e2k</a>
	</p>
</section>

<footer class="site-footer">
	<small>© u1e2k — Updated 2025-11-18</small>
</footer>

</div>

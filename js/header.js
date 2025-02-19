class SpecialHeader extends HTMLElement {
    connectedCallback() {
        this.innerHTML = `<nav class="fh5co-nav" role="navigation">
		<div class="top">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 text-right">
						<p class="num">Call: +91 00000 00000</p>
						<ul class="fh5co-social">
							<li><a href="#"><i class="icon-youtube"></i></a></li>
							<!-- <li><a href="#"><i class="icon-dribbble"></i></a></li>
							<li><a href="#"><i class="icon-github"></i></a></li> -->
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="top-menu">
			<div class="container">
				<div class="row">
					<div class="col-xs-2">
						<div id="fh5co-logo"><a href="index.html"><img src="/images/logo.png" alt="Logo" id="main-logo"></a></div>
					</div>
					<div class="col-xs-10 text-right menu-1">
						<ul>
							<li class="active"><a href="index.html">Home</a></li>
							<li><a href="about.html">About</a></li>
                             <li class="has-dropdown">
								<a href="blog.html">Issues</a>
								<ul class="dropdown">
									<li><a href="#">Current Issue</a></li>
									<li><a href="#">Archieves</a></li>
								</ul>
							</li>
							<li><a href="pricing.html">Editorial Board</a></li>
							<li><a href="pricing.html">Feedback</a></li>
							<li class="has-dropdown">
								<a href="blog.html">Submission</a>
								<ul class="dropdown">
									<li><a href="#">Guideliness</a></li>
								</ul>
							</li>
							<li><a href="contact.html">Contact</a></li>
						</ul>
					</div>
				</div>

			</div>
		</div>
	</nav>`;
    }
}

customElements.define('special-header', SpecialHeader);

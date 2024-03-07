<!-- Widget v2.0 by Katana -->

{foreach from=$items item=testimonial name=testimonials}
<figure>
    <div class="flex-container">
        {if $show_image}<img src="{$urls.base_url}{$testimonial.image.url}" width="100" height="100" loading="lazy">{/if}
    </div>
    <blockquote>
        <cite class="pk-text">{$testimonial.cite}</cite>
        {if $show_name}<cite class="pk-author">{$testimonial.name}</cite>{/if}
        {if $show_occupation}&nbsp;<cite class="pk-occupation">{$testimonial.occupation}</cite>{/if}
    </blockquote>
</figure>
{foreachelse}
<div class="elementor-alert elementor-alert-danger">No Testimonials</div>
{/foreach}

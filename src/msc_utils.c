
#include "msc_utils.h"


int id(const char *fn, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    FILE *f = fopen(fn, "a"); 
    vfprintf(f, format, args);
    fclose(f);
    va_end(args);
}


/**
 * Sends a brigade with an error bucket down the filter chain.
 */
apr_status_t send_error_bucket(msc_t *msr, ap_filter_t *f, int status)
{
    apr_bucket_brigade *brigade = NULL;
    apr_bucket *bucket = NULL;

    /* Set the status line explicitly for the error document */
	f->r->status = status;
    f->r->status_line = ap_get_status_line(f->r->status);
	
	ap_send_error_response(f->r, 0);

    return APR_SUCCESS;
}

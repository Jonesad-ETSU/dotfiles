void
tcl(Monitor * m)
{
	int x, y, h, w, r, oe=enablegaps, ie = enablegaps, mw, my, ty, sw, bdw;
	unsigned int i, n;
	Client * c;

	for (n = 0, c = nexttiled(m->clients); c;
	        c = nexttiled(c->next), n++);
  
	if (n == 0)
		return;
  r = n;
	c = nexttiled(m->clients);

	mw = m->mfact * m->ww;
	sw = (m->ww - mw) / 2;
	bdw = (2 * c->bw);
	resize(c,							//RESIZE CENTER
	       n < 3 ? m->wx : m->wx + sw,
	       m->wy,
	       n == 1 ? m->ww - bdw : mw - bdw,
	       m->wh - bdw,
	       False);
  r--;

	if (--n == 0)	
		return;

	w = (m->ww - mw) / ((n > 1) + 1);
	c = nexttiled(c->next);

	if (n > 1)
	{
		x = m->wx + ((n > 1) ? mw + sw : mw);
		y = m->wy;
		h = m->wh / (n / 2);

		if (h < bh)
			h = m->wh;
    //RESIZE RIGHT VVVVV
		for (i = 0; c && i < n / 2; c = nexttiled(c->next), i++)
		{
			resize(c,					//RESIZE
			       x,
			       y,
			       w - bdw,
			       (i + 1 == n / 2) ? m->wy + m->wh - y - bdw : h - bdw,
			       False);
      r--;
			if (h != m->wh)
				y = c->y + HEIGHT(c);
		}
	}

	x = (n + 1 / 2) == 1 ? mw : m->wx;
	y = m->wy;
	h = m->wh / ((n + 1) / 2);

	if (h < bh)
		h = m->wh;
  //RESIZE LEFT VVV
	for (i = 0; c; c = nexttiled(c->next), i++)
	{
    resize( c,
      x + m->gappoh*oe,
      y - bdw - m->gappov*oe + m->gappiv*ie,
      w - bdw - 2*m->gappoh*oe - m->gappih*ie,
      m->wh / r - bdw - 2*m->gappov*oe - m->gappiv*ie, 
      0);
		if (h != m->wh)
			y = c->y + HEIGHT(c) + 2*bdw + m->gappiv*ie;
	}
}

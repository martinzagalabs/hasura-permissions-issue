INSERT INTO public.products (id, name, public_a, public_b, semi_public_c, semi_public_d, security)
VALUES  ('bd4b1417-5234-4d9c-b6e0-124cc24ea429', 'Allowed Product A', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'allowed'),
        ('3859109b-4196-45fa-8e3d-d5a1517af809', 'Allowed Product B', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'allowed'),
        ('da97e554-7e88-4d20-879b-4c7104f539da', 'NOT Allowed Product C', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'blocked'),
        ('b27259f4-9f71-44a1-925a-755977432e4b', 'NOT Allowed Product D', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'lorem ipsum', 'blocked');

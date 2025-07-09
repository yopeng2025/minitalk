/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yopeng <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/17 14:58:25 by yopeng            #+#    #+#             */
/*   Updated: 2025/06/17 17:34:58 by yopeng           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

volatile sig_atomic_t	g_ack = 0;

void	sig_ack(int sig)
{
	(void)sig;
	g_ack = 1;
}

void	send_char(pid_t pid, unsigned char c)
{
	int	bit;

	bit = 8;
	while (bit--)
	{
		if ((c >> bit) & 1)
			kill (pid, SIGUSR1);
		else
			kill (pid, SIGUSR2);
		while (!g_ack)
			usleep(50);
		g_ack = 0;
	}
}

void	send_str(pid_t pid, char *str)
{
	while (*str)
		send_char(pid, *str++);
	send_char(pid, '\0');
}

int	main(int ac, char **av)
{
	struct sigaction	sa;

	sa.sa_handler = sig_ack;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = SA_RESTART;
	sigaction(SIGUSR1, &sa, NULL);
	if (ac != 3)
	{
		ft_printf("Usage: %s <PID> <message>\n", av[0]);
		return (1);
	}
	send_str(ft_atoi(av[1]), av[2]);
	return (0);
}

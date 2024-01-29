import 'package:finwise/modules/budget_plan/widgets/filter_bar.dart';
import 'package:flutter/material.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const SizedBox(
          height: 16,
        ),
        const FilterBar(
          filterTitles: [
            'All',
            'Recently',
            'Earliest',
            'Lowest',
            'Highest',
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        _transaction(),
        const SizedBox(
          height: 16,
        ),
        _transaction(),
      ],
    );
  }

  Widget _title() {
    return const Text(
      'Transaction',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF191B29),
      ),
    );
  }

  Widget _transaction() {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Today',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333652),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Divider(
                color: Color(0xFFE9EAF1),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _transactionCard(),
              const Divider(
                color: Color(0xFFE9EAF1),
              ),
              _transactionCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _transactionCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFFEE5353),
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(
                  Icons.car_rental_outlined,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bus',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  Text('12 December, 2023'),
                ],
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                '\$3',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEE5353),
                ),
              ),
              Icon(
                Icons.arrow_right,
                size: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

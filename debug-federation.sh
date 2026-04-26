#!/bin/bash
# Mastodon Federation Debug Script

echo "=== MASTODON FEDERATION DIAGNOSTICS ==="
echo ""

echo "1. Container Status:"
docker compose ps
echo ""

echo "2. Sidekiq Status:"
docker exec mastodon-web ps aux | grep sidekiq
echo ""

echo "3. Test Outbound Federation:"
docker exec mastodon-web curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" https://mastodon.social/.well-known/nodeinfo
echo ""

echo "4. Check Your Instance is Reachable:"
echo "Testing: https://mastodon.casjay.social/.well-known/nodeinfo"
curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" https://mastodon.casjay.social/.well-known/nodeinfo
echo ""

echo "5. Sidekiq Queue Sizes:"
docker exec mastodon-web bash -c "cd /app/www && bundle exec rails runner \"
puts 'Default queue: ' + Sidekiq::Queue.new('default').size.to_s
puts 'Push queue: ' + Sidekiq::Queue.new('push').size.to_s  
puts 'Pull queue: ' + Sidekiq::Queue.new('pull').size.to_s
puts 'Ingress queue: ' + Sidekiq::Queue.new('ingress').size.to_s
puts 'Mailers queue: ' + Sidekiq::Queue.new('mailers').size.to_s
puts 'Dead jobs: ' + Sidekiq::DeadSet.new.size.to_s
\""
echo ""

echo "6. Recent Web Logs (errors only):"
docker compose logs --tail=100 web | grep -i "error\|fail\|timeout" | tail -20
echo ""

echo "7. Check DNS Resolution:"
docker exec mastodon-web nslookup mastodon.social || echo "DNS check failed"
echo ""

echo "8. Check Database Connection:"
docker exec mastodon-web bash -c "cd /app/www && bundle exec rails runner 'puts Account.count.to_s + \" accounts in database\"'"
echo ""

echo "9. Check Redis Connection:"
docker exec mastodon-redis redis-cli ping
echo ""

echo "10. Check if Scheduler is Running:"
docker exec mastodon-web ps aux | grep scheduler
echo ""

echo "=== DIAGNOSTICS COMPLETE ==="
echo ""
echo "If you see large numbers in dead jobs or high queue sizes,"
echo "that indicates federation is backing up or failing."

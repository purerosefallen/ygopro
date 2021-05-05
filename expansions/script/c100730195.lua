--高速决斗技能-仪式典礼
Duel.LoadScript("speed_duel_common.lua")
function c100730195.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730195.skill,c100730195.con,aux.Stringid(100730195,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730195.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730195.filter,tp,LOCATION_HAND,0,1,nil)
end
function c100730195.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730195)
	local g=Duel.SelectMatchingCard(tp,c100730195.filter,tp,LOCATION_HAND,0,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g)
		local mg=Duel.GetMatchingGroup(c100730195.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil,g:GetFirst())
		if mg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=mg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
		end
	end
end
function c100730195.filter(c,tp)
	return bit.band(c:GetType(),0x82)==0x82
		and Duel.IsExistingMatchingCard(c100730195.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c)
end
function c100730195.filter2(c,mc)
	return bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToHand() and aux.IsCodeListed(mc,c:GetCode())
end
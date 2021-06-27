--高速决斗技能-雷·风·水合体！
Duel.LoadScript("speed_duel_common.lua")
function c100730096.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730096.skill,c100730096.con,aux.Stringid(100730096,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730096.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,2,nil,25955164,98434877,62340868)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,25833572)
end
function c100730096.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730096)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,2,nil,25955164,98434877,62340868)
	local c=g:Select(tp,2,2,nil)
	if c then
		Duel.ConfirmCards(1-tp,c)
		Duel.Remove(c,POS_FACEUP,REASON_COST)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100730096.filter),tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
		if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:GetFirst()
		if tc and Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP) then
			local e1=Effect.GlobalEffect()   
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CHANGE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(0,1)
			e1:SetValue(c100730096.damval)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
			end
			Duel.SpecialSummonComplete()
		end
	end
end

function c100730096.filter(c)
	return c:IsCode(25833572)
end

function c100730096.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
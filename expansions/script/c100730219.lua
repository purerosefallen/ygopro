--高速决斗技能-超进化之茧
Duel.LoadScript("speed_duel_common.lua")
function c100730219.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730219.skill,c100730219.con,aux.Stringid(100730219,0))
	aux.SpeedDuelAtMainPhase(c,c100730219.skill2,c100730219.con2,aux.Stringid(100730219,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730219.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT) and c:IsReleasableByEffect()
		and c:GetEquipCount()>0
end
function c100730219.filter(c,e,tp)
	return c:IsRace(RACE_INSECT) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end

function c100730219.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730219.cfilter,tp,LOCATION_MZONE,loc,1,nil)
		and Duel.IsExistingMatchingCard(c100730219.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
end
function c100730219.skill(e,tp,eg,ep,ev,re,r,rp)
	local loc=LOCATION_MZONE
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then loc=0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c100730219.cfilter,tp,LOCATION_MZONE,loc,1,1,nil)
	if g:GetCount()>0 and Duel.Release(g,REASON_EFFECT)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c100730219.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
function c100730219.tdfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsAbleToDeck()
end
function c100730219.con2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730219.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,1)
end
function c100730219.skill2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c100730219.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tc=g:GetFirst()
	Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	if tc:IsLocation(LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	if tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end

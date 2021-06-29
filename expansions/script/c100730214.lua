--高速决斗技能-变态发育
Duel.LoadScript("speed_duel_common.lua")
function c100730214.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730214.skill,c100730214.con,aux.Stringid(100730214,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730214.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730214.rmfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730214.skill(e,tp,eg,ep,ev,re,r,rp,chk)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730214)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil)
	if chk==0 then return g:CheckSubGroup(c100730214.fselect,2,2) end
	local rg=g:SelectSubGroup(tp,c100730214.fselect,false,2,2)
	Duel.SendtoDeck(rg,nil,tp,2,REASON_EFFECT)
	local g=Duel.SelectMatchingCard(tp,c100730214.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.SpecialSummon(g:GetFirst(),0,tp,tp,true,true,POS_FACEUP)
	local e2=Effect.GlobalEffect()   
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(c100730214.damval)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,3,nil,13235258)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,tp,REASON_RULE)
end

function c100730214.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
function c100730214.filter(c)
	return c:IsCode(48579379)
end

function c100730214.fselect(g)
	return g:IsExists(c100730214.rmfilter,1,nil)
end
function c100730214.rmfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsType(TYPE_NORMAL) and c:IsLevelBelow(3) and c:IsFaceup()
end
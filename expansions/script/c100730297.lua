--高速决斗技能-重铠超量（黑鳍条）
Duel.LoadScript("speed_duel_common.lua")
function c100730297.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730297.skill,c100730297.con,aux.Stringid(100730297,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730297.Isshark(c)
	return c:IsCode(5014629) or c:IsCode(74416224) and c:IsFaceup()
end

function c100730297.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730297.Isshark,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp)
end
function c100730297.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730297)
	local g1=Duel.SelectMatchingCard(tp,c100730297.Isshark,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local c=Duel.CreateToken(tp,25853045)
	Duel.SendtoDeck(c,tp,1,REASON_RULE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,25853045)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc2=g2:GetFirst()
	if tc2 then
		Duel.BreakEffect()
		local tc=g1:GetFirst()
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(tc2,mg)
		end
		tc2:SetMaterial(g1)
		Duel.Overlay(tc2,g1)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		tc2:CompleteProcedure()
		local g3=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,0,1,nil,17201174)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		if Duel.GetMZoneCount(tp)<1 or g3:GetCount()==0 then return end
		local sc=g3:GetFirst()
		Duel.SpecialSummon(sc,0,tp,tp,true,true,POS_FACEUP)
	end
end